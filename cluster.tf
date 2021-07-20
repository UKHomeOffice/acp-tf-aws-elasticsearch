resource "aws_elasticsearch_domain" "cluster" {
  domain_name           = var.domain_name
  elasticsearch_version = var.elasticsearch_version

  cluster_config {
    instance_type            = var.data_instance_type
    instance_count           = var.data_instance_count

    dedicated_master_enabled = var.master_enabled
    dedicated_master_count   = var.master_instance_count
    dedicated_master_type    = var.master_instance_type
    
    zone_awareness_enabled   = true
    zone_awareness_config {
      availability_zone_count = 3
    }
  }

  snapshot_options {
    automated_snapshot_start_hour = var.automated_snapshot_start_hour
  }

  vpc_options {

    subnet_ids = var.subnet_ids

    security_group_ids = [aws_security_group.es.id]
  }

  tags = var.tags

  encrypt_at_rest {
    enabled = var.encrypt_at_rest_enabled
  }

  ebs_options {
    ebs_enabled = var.ebs_enabled
    volume_type = var.volume_type
    volume_size = var.volume_size
  }

  log_publishing_options {
    log_type = "ES_APPLICATION_LOGS"
    enabled = true
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.es_domain_log_group.arn
  }

  log_publishing_options {
    log_type = "INDEX_SLOW_LOGS"
    enabled = true
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.es_domain_log_group.arn
  }

  domain_endpoint_options {
    enforce_https = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  node_to_node_encryption {
    enabled = true
  }

  advanced_security_options {
    enabled = true

    internal_user_database_enabled = true

    master_user_options {
      master_user_name = var.master_user_name
      master_user_password = var.master_user_password
    }
  }

}

resource "aws_iam_service_linked_role" "es" {
  count            = var.create_iam_service_linked_role == "true" ? 1 : 0
  aws_service_name = "es.amazonaws.com"
}

resource "aws_elasticsearch_domain_policy" "main" {
  domain_name = aws_elasticsearch_domain.cluster.domain_name

  access_policies = <<POLICIES
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:ESHttp*",
            "Principal": {
                  "AWS": "*"
                  },
            "Effect": "Allow",
            "Resource": "${aws_elasticsearch_domain.cluster.arn}/*"
        }
    ]
}
POLICIES
}

resource "null_resource" "create_local_users" {
  count = var.admin_users != "" ? 1 : 0

  triggers = {
    users = join(",", var.admin_users)
  }

  provisioner "local-exec" {
    command = "./${local_file.script.filename}"
    interpreter = ["sh"]
  }

  depends_on = [
    aws_elasticsearch_domain.cluster
  ]
}

resource "local_file" "script" {
    content  = templatefile("${path.module}/files/create_admin_users.tmpl", 
                {
                  es_user=var.master_user_name,
                  es_pass=var.master_user_password,
                  aws_es_endpoint=aws_elasticsearch_domain.cluster.endpoint,
                  admin_users=var.admin_users
                })
    filename = "${path.module}/admin-user-script.sh"
}

resource "null_resource" "bootstrap_service_users" {

  provisioner "local-exec" {
    command = "./${local_file.script.filename}"
    interpreter = ["sh"]
  }

  depends_on = [
    aws_elasticsearch_domain.cluster
  ]
}

resource "local_file" "service_users_script" {
    content  = templatefile("${path.module}/files/bootstrap_service_users.tmpl", 
                {
                  es_user=var.master_user_name,
                  es_pass=var.master_user_password,
                  aws_es_endpoint=aws_elasticsearch_domain.cluster.endpoint,
                  logstash_username=var.logstash_username,
                  logstash_password=var.logstash_password,
                  proxy_cluster_permissions=var.proxy_cluster_permissions,
                  proxy_username=var.proxy_username,
                  proxy_password=var.proxy_password,
                })
    filename = "${path.module}/bootstrap-service-script.sh"
}
