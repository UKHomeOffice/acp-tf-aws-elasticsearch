resource "aws_elasticsearch_domain" "cluster" {
  domain_name           = var.domain_name
  elasticsearch_version = var.elasticsearch_version

  cluster_config {
    instance_type = var.instance_type
    instance_count = var.instance_count

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

