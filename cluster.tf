resource "aws_elasticsearch_domain" "cluster" {
  domain_name           = var.domain_name
  elasticsearch_version = var.elasticsearch_version

  cluster_config {
    instance_type  = var.data_instance_type
    instance_count = var.data_instance_count

    dedicated_master_enabled = var.master_enabled
    dedicated_master_count   = var.master_instance_count
    dedicated_master_type    = var.master_instance_type

    zone_awareness_enabled = var.zone_awareness_enabled
    dynamic "zone_awareness_config" {
      for_each = var.zone_awareness_enabled ? [true] : []
      content {
        availability_zone_count = var.zone_awareness_availability_count
      }
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

  advanced_options = {
    "indices.query.bool.max_clause_count"    = var.max_clause_count
    "rest.action.multi.allow_explicit_index" = var.allow_explicit_index
  }
  lifecycle {
    ignore_changes = [
      advanced_options ## temporarily adding this ignore changes until all environments are on provider 3.70.0 and above to remove aws values from plan e.g override_main_response_version
    ]
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

resource "null_resource" "create_service_user_file" {

  triggers = {
    logstash_username            = var.logstash_username
    logstash_password            = var.logstash_password
    logstash_cluster_permissions = join(",", var.logstash_cluster_permissions)
    logstash_index_permissions   = join(",", var.logstash_index_permissions)
    proxy_username               = var.proxy_username
    proxy_password               = var.proxy_password
    proxy_cluster_permissions    = join(",", var.proxy_cluster_permissions)
    proxy_index_permissions      = join(",", var.proxy_index_permissions)
    kibana_username              = var.kibana_username
    lambda_readonly_username     = var.lambda_readonly_username
    lambda_readonly_password     = var.lambda_readonly_password
  }
  provisioner "local-exec" {
    command = format(
      "cat <<\"EOF\" > \"%s\"\n%s\nEOF",
      "${path.module}/${var.domain_name}-bootstrap-service-script.sh",
      local.service_user_content
    )
  }
  depends_on = [
    time_sleep.wait_60_seconds
  ]
}

resource "null_resource" "exec_service_user_file" {
  triggers = {
    logstash_username            = var.logstash_username
    logstash_password            = var.logstash_password
    logstash_cluster_permissions = join(",", var.logstash_cluster_permissions)
    logstash_index_permissions   = join(",", var.logstash_index_permissions)
    proxy_username               = var.proxy_username
    proxy_password               = var.proxy_password
    proxy_cluster_permissions    = join(",", var.proxy_cluster_permissions)
    proxy_index_permissions      = join(",", var.proxy_index_permissions)
    kibana_username              = var.kibana_username
    lambda_readonly_username     = var.lambda_readonly_username
    lambda_readonly_password     = var.lambda_readonly_password
  }
  provisioner "local-exec" {
    command     = "./${path.module}/${var.domain_name}-bootstrap-service-script.sh"
    interpreter = ["sh"]
  }
  depends_on = [
    null_resource.create_service_user_file
  ]
}

resource "null_resource" "create_cluster_indices_file" {
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
  depends_on = [
    time_sleep.wait_60_seconds
  ]
}

resource "null_resource" "exec_cluster_indices_file" {
  count = var.large_index_list != [] || var.medium_index_list != [] || var.small_index_list != [] ? 1 : 0
  triggers = {
    large_index_refresh_interval  = var.large_index_refresh_interval
    medium_index_refresh_interval = var.medium_index_refresh_interval
    small_index_refresh_interval  = var.small_index_refresh_interval
    large_index_shard_count       = var.large_index_shard_count
    medium_index_shard_count      = var.medium_index_shard_count
    small_index_shard_count       = var.small_index_shard_count
    large_index_replica_count     = var.large_index_replica_count
    medium_index_replica_count    = var.medium_index_replica_count
    small_index_replica_count     = var.small_index_replica_count
    large_index_field_limit       = var.large_index_field_limit
    large_index_list              = join(",", var.large_index_list)
    medium_index_list             = join(",", var.medium_index_list)
    small_index_list              = join(",", var.small_index_list)
  }
  provisioner "local-exec" {
    command     = "./${path.module}/${var.domain_name}-cluster-index-script.sh"
    interpreter = ["sh"]
  }
  depends_on = [
    null_resource.create_cluster_indices_file
  ]
}

