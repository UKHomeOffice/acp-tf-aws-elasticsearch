resource "aws_elasticsearch_domain" "cluster" {
  domain_name           = var.domain_name
  elasticsearch_version = var.elasticsearch_version

  cluster_config {
    instance_type  = var.data_instance_type
    instance_count = var.data_instance_count

    dedicated_master_enabled = var.master_enabled
    dedicated_master_count   = var.master_instance_count
    dedicated_master_type    = var.master_instance_type

    zone_awareness_enabled = true
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
    log_type                 = "ES_APPLICATION_LOGS"
    enabled                  = true
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.es_domain_log_group.arn
  }

  log_publishing_options {
    log_type                 = "INDEX_SLOW_LOGS"
    enabled                  = true
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.es_domain_log_group.arn
  }

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  node_to_node_encryption {
    enabled = true
  }

  advanced_security_options {
    enabled = true

    internal_user_database_enabled = true

    master_user_options {
      master_user_name     = var.master_user_name
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

resource "time_sleep" "wait_60_seconds" {
  depends_on = [aws_elasticsearch_domain.cluster]

  create_duration = "60s"
}

resource "null_resource" "create_local_users" {
  count = var.admin_users != [] ? 1 : 0
  triggers = {
    users = join(",", var.admin_users)
  }
  provisioner "local-exec" {
    command     = "./${path.module}/${var.domain_name}-admin-user-script.sh"
    interpreter = ["sh"]
  }
  depends_on = [
    time_sleep.wait_60_seconds
  ]
}

resource "null_resource" "admin_file" {
  count = var.admin_users != [] ? 1 : 0
  triggers = {
    admin_users = join(",", var.admin_users)
  }
  provisioner "local-exec" {
    command = format(
      "cat <<\"EOF\" > \"%s\"\n%s\nEOF",
      "${path.module}/${var.domain_name}-admin-user-script.sh",
      local.admin_content
    )
  }
}

resource "null_resource" "bootstrap_service_users" {
  triggers = {
    logstash_username = var.logstash_username
    proxy_username = var.proxy_username
  }
  provisioner "local-exec" {
    command     = "./${path.module}/${var.domain_name}-bootstrap-service-script.sh"
    interpreter = ["sh"]
  }
  depends_on = [
    time_sleep.wait_60_seconds
  ]
}

resource "null_resource" "service_user_file" {
  triggers = {
    logstash_username = var.logstash_username
    proxy_username = var.proxy_username
  }
  provisioner "local-exec" {
    command = format(
      "cat <<\"EOF\" > \"%s\"\n%s\nEOF",
      "${path.module}/${var.domain_name}-bootstrap-service-script.sh",
      local.service_user_content
    )
  }
}

resource "null_resource" "create_cluster_indices" {
  count = var.large_index_list != [] || var.medium_index_list != [] || var.small_index_list != [] ? 1 : 0
  triggers = {
    large_index_list  = join(",", var.large_index_list)
    medium_index_list = join(",", var.medium_index_list)
    small_index_list  = join(",", var.small_index_list)
  }
  provisioner "local-exec" {
    command     = "./${path.module}/${var.domain_name}-cluster-index-script.sh"
    interpreter = ["sh"]
  }
  depends_on = [
    time_sleep.wait_60_seconds
  ]
}

resource "null_resource" "indices_file" {
  count = var.large_index_list != [] || var.medium_index_list != [] || var.small_index_list != [] ? 1 : 0
  triggers = {
    template = local.index_content
  }
  provisioner "local-exec" {
    command = format(
      "cat <<\"EOF\" > \"%s\"\n%s\nEOF",
      "${path.module}/${var.domain_name}-cluster-index-script.sh",
      local.index_content
    )
  }
}

resource "null_resource" "create_cluster_tenants" {
  count = var.tenant_list != [] ? 1 : 0
  triggers = {
    tenant_list = join(",", var.tenant_list)
  }
  provisioner "local-exec" {
    command     = "./${path.module}/${var.domain_name}-tenant-script.sh"
    interpreter = ["sh"]
  }
  depends_on = [
    time_sleep.wait_60_seconds
  ]
}

resource "null_resource" "tenant_file" {
  count = var.tenant_list != [] ? 1 : 0
  triggers = {
    template = local.tenant_content
  }
  provisioner "local-exec" {
    command = format(
      "cat <<\"EOF\" > \"%s\"\n%s\nEOF",
      "${path.module}/${var.domain_name}-tenant-script.sh",
      local.tenant_content
    )
  }
}
