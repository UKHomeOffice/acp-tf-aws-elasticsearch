locals {
  service_user_content = templatefile("${path.module}/files/bootstrap_service_users.tmpl",
    {
      es_user                             = var.master_user_name
      es_pass                             = var.master_user_password
      aws_es_endpoint                     = aws_elasticsearch_domain.cluster.endpoint
      logstash_username                   = var.logstash_username
      logstash_password                   = var.logstash_password
      logstash_cluster_permissions        = var.logstash_cluster_permissions
      logstash_index_permissions          = var.logstash_index_permissions
      proxy_username                      = var.proxy_username
      proxy_password                      = var.proxy_password
      proxy_cluster_permissions           = var.proxy_cluster_permissions
      proxy_index_permissions             = var.proxy_index_permissions
      kibana_username                     = var.kibana_username
      kibana_password                     = var.kibana_password
      lambda_readonly_username            = var.lambda_readonly_username
      lambda_readonly_password            = var.lambda_readonly_password
      lambda_readonly_cluster_permissions = var.lambda_readonly_cluster_permissions
      lambda_readonly_index_permissions   = var.lambda_readonly_index_permissions
      kms_key_id                          = data.aws_kms_key.key.id
      encrypted_password_payload          = var.encrypted_password_payload
  })
  index_content = templatefile("${path.module}/files/create_indices.tmpl",
    {
      es_user                                 = var.master_user_name
      es_pass                                 = var.master_user_password
      aws_es_endpoint                         = aws_elasticsearch_domain.cluster.endpoint
      large_index_list                        = var.large_index_list
      large_index_shard_count                 = var.large_index_shard_count
      large_index_shard_count                 = var.large_index_shard_count
      large_index_refresh_interval            = var.large_index_refresh_interval
      large_index_replica_count               = var.large_index_replica_count
      large_index_rollover_size               = var.large_index_rollover_size
      large_index_rollover_age                = var.large_index_rollover_age
      large_index_retention                   = var.large_index_retention
      large_index_field_limit                 = var.large_index_field_limit
      large_index_max_docvalue_fields_search  = var.large_index_max_docvalue_fields_search
      medium_index_list                       = var.medium_index_list
      medium_index_shard_count                = var.medium_index_shard_count
      medium_index_shard_count                = var.medium_index_shard_count
      medium_index_refresh_interval           = var.medium_index_refresh_interval
      medium_index_replica_count              = var.medium_index_replica_count
      medium_index_rollover_size              = var.medium_index_rollover_size
      medium_index_rollover_age               = var.medium_index_rollover_age
      medium_index_retention                  = var.medium_index_retention
      medium_index_max_docvalue_fields_search = var.medium_index_max_docvalue_fields_search
      small_index_list                        = var.small_index_list
      small_index_shard_count                 = var.small_index_shard_count
      small_index_shard_count                 = var.small_index_shard_count
      small_index_refresh_interval            = var.small_index_refresh_interval
      small_index_replica_count               = var.small_index_replica_count
      small_index_rollover_size               = var.small_index_rollover_size
      small_index_rollover_age                = var.small_index_rollover_age
      small_index_retention                   = var.small_index_retention
      small_index_max_docvalue_fields_search  = var.small_index_max_docvalue_fields_search
      kms_key_id                              = data.aws_kms_key.key.id
      encrypted_password_payload              = var.encrypted_password_payload
  })
}