locals {
    admin_content = templatefile("${path.module}/files/create_admin_users.tmpl",
    {
      es_user         = var.master_user_name
      es_pass         = var.master_user_password
      aws_es_endpoint = aws_elasticsearch_domain.cluster.endpoint
      admin_users     = var.admin_users
      kms_key_id      = data.aws_kms_key.key.id
      encrypted_password_payload = var.encrypted_password_payload
    })
    tenant_content = templatefile("${path.module}/files/create_tenants.tmpl",
    {
        es_user         = var.master_user_name
        es_pass         = var.master_user_password
        aws_es_endpoint = aws_elasticsearch_domain.cluster.endpoint
        tenant_list     = var.tenant_list
        kms_key_id      = data.aws_kms_key.key.id
        encrypted_password_payload = var.encrypted_password_payload
    })
    service_user_content = templatefile("${path.module}/files/bootstrap_service_users.tmpl",
    {
      es_user                      = var.master_user_name
      es_pass                      = var.master_user_password
      aws_es_endpoint              = aws_elasticsearch_domain.cluster.endpoint
      logstash_username            = var.logstash_username
      logstash_password            = var.logstash_password
      logstash_cluster_permissions = var.logstash_cluster_permissions
      logstash_index_permissions   = var.logstash_index_permissions
      proxy_username               = var.proxy_username
      proxy_password               = var.proxy_password
      kibana_username              = var.kibana_username
      kibana_password              = var.kibana_password
      kms_key_id                   = data.aws_kms_key.key.id
      encrypted_password_payload   = var.encrypted_password_payload
    })
    index_content = templatefile("${path.module}/files/create_indices.tmpl",
    {
        es_user                       = var.master_user_name
        es_pass                       = var.master_user_password
        aws_es_endpoint               = aws_elasticsearch_domain.cluster.endpoint
        large_index_list              = var.large_index_list
        large_index_shard_count       = var.large_index_shard_count
        large_index_shard_count       = var.large_index_shard_count
        large_index_refresh_interval  = var.large_index_refresh_interval
        large_index_replica_count     = var.large_index_replica_count
        large_index_rollover_size     = var.large_index_rollover_size
        large_index_rollover_age      = var.large_index_rollover_age
        large_index_retention         = var.large_index_retention
        large_index_field_limit       = var.large_index_field_limit
        medium_index_list             = var.medium_index_list
        medium_index_shard_count      = var.medium_index_shard_count
        medium_index_shard_count      = var.medium_index_shard_count
        medium_index_refresh_interval = var.medium_index_refresh_interval
        medium_index_replica_count    = var.medium_index_replica_count
        medium_index_rollover_size    = var.medium_index_rollover_size
        medium_index_rollover_age     = var.medium_index_rollover_age
        medium_index_retention        = var.medium_index_retention
        small_index_list              = var.small_index_list
        small_index_shard_count       = var.small_index_shard_count
        small_index_shard_count       = var.small_index_shard_count
        small_index_refresh_interval  = var.small_index_refresh_interval
        small_index_replica_count     = var.small_index_replica_count
        small_index_rollover_size     = var.small_index_rollover_size
        small_index_rollover_age      = var.small_index_rollover_age
        small_index_retention         = var.small_index_retention
        kms_key_id                    = data.aws_kms_key.key.id
        encrypted_password_payload    = var.encrypted_password_payload
    })
}