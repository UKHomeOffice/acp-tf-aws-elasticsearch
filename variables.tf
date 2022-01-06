variable "domain_name" {

}

variable "elasticsearch_version" {

}

variable "data_instance_type" {

}

variable "data_instance_count" {

}

variable "master_enabled" {
  default     = false
  description = "Boolean value to enable/disable dedicated master nodes."
}

variable "master_instance_count" {
  default     = 0
  description = "The amount of dedicated master nodes within the cluster."
}

variable "master_instance_type" {
  default     = ""
  description = "The instance type for the dedicated master nodes."
}

variable "automated_snapshot_start_hour" {
  default = 23
}

variable "tags" {

}

variable "encrypt_at_rest_enabled" {
  default = true
}

variable "ebs_enabled" {
  default = false
}

variable "volume_type" {
  default = ""
}

variable "volume_size" {
  default = 0
}

variable "admin_users" {
  description = "group of users to be created in kibana."
  default     = []
}

variable "tenant_list" {
  description = "List of tenant names to be provisioned in Elasticsearch."
  default     = []
}

variable "large_index_list" {
  description = "List of larger sized indexes to be created in Elasticsearch. e.g expected 1TB per day"
  default     = []
}

variable "large_index_shard_count" {
  description = "Updates the large index template to define the amount of shards set for all indices."
  default     = "12"
}

variable "large_index_refresh_interval" {
  description = "Updates the large index template to define the interval between each index refresh."
  default     = "30s"
}

variable "large_index_replica_count" {
  description = "Updates the large index template to define the amount of replica shards set for all indices."
  default     = "1"
}

variable "large_index_rollover_size" {
  description = "Updates the large ISM policy with the index size limit before triggering the rollover action."
  default     = "600gb"
}

variable "large_index_rollover_age" {
  description = "Updates the large ISM policy with the index age limit before triggering the rollover action."
  default     = "1d"
}

variable "large_index_retention" {
  description = "Updates the ISM policy with the index retention time before being deleted."
  default     = "7d"
}

variable "large_index_field_limit" {
  description = "Large indices are likely to breach the default 1000 limit for elasticsearch fields, this set the updated limit in the index template."
  default     = "2000"
}

variable "medium_index_list" {
  description = "List of medium sized indexes to be created in Elasticsearch. e.g 30GB per day"
  default     = []
}

variable "medium_index_shard_count" {
  description = "Updates the medium index template to define the amount of shards set for all indices."
  default     = "6"
}

variable "medium_index_refresh_interval" {
  description = "Updates the medium index template to define the interval between each index refresh."
  default     = "30s"
}

variable "medium_index_replica_count" {
  description = "Updates the medium index template to define the amount of replica shards set for all indices."
  default     = "1"
}

variable "medium_index_rollover_size" {
  description = "Updates the medium ISM policy with the index size limit before triggering the rollover action."
  default     = "300gb"
}

variable "medium_index_rollover_age" {
  description = "Updates the medium ISM policy with the index age limit before triggering the rollover action."
  default     = "1d"
}

variable "medium_index_retention" {
  description = "Updates the medium ISM policy with the index retention time before being deleted."
  default     = "7d"
}

variable "small_index_list" {
  description = "List of small sized indexes to be created in Elasticsearch. e.g expected 5GB per day"
  default     = []
}

variable "small_index_shard_count" {
  description = "Updates the small index template to define the amount of shards set for all indices."
  default     = "1"
}

variable "small_index_refresh_interval" {
  description = "Updates the small index template to define the interval between each index refresh."
  default     = "30s"
}

variable "small_index_replica_count" {
  description = "Updates the small index template to define the amount of replica shards set for all indices."
  default     = "1"
}

variable "small_index_rollover_size" {
  description = "Updates the small ISM policy with the index size limit before triggering the rollover action."
  default     = "30gb"
}

variable "small_index_rollover_age" {
  description = "Updates the small ISM policy with the index age limit before triggering the rollover action."
  default     = "1d"
}

variable "small_index_retention" {
  description = "Updates the ISM policy with the index retention time before being deleted."
  default     = "7d"
}

variable "logstash_username" {
  description = "Logstash username in Kibana RBAC"
  default     = ""
}

variable "logstash_password" {
  description = "Logstash password in Kibana RBAC"
  default     = ""
}

variable "logstash_index_permissions" {
  description = "Logstash index-level permissions."
  default = [
    "read",
    "get",
    "indices:data/write/bulk",
    "indices:data/write/bulk*",
    "indices:data/write/index",
    "indices:admin/mapping/put",
    "indices:monitor/settings/get",
    "indices:monitor/stats"
  ]
}

variable "logstash_cluster_permissions" {
  description = "Logstash cluster-level permissions."
  default = [
    "cluster:admin/ingest/pipeline/get",
    "cluster:admin/ingest/pipeline/put",
    "cluster_monitor",
    "indices:data/write/bulk",
    "indices:data/write/bulk*",
    "indices:data/write/index",
    "indices:admin/mapping/put"
  ]
}

variable "proxy_username" {
  description = "Proxy username in Kibana RBAC"
  default     = ""
}

variable "proxy_password" {
  description = "Proxy password in Kibana RBAC"
  default     = ""
}

variable "kibana_username" {
  description = "Kibana username in Kibana RBAC"
  default     = ""
}

variable "kibana_password" {
  description = "Kibana password in Kibana RBAC"
  default     = ""
}

variable "visualization_role" {
  description = "Boolean to create role with the ability to create visualizations and dashboards."
  default     = true
}

variable "master_user_name" {

}

variable "master_user_password" {
  description = "The master user password must contain at least one uppercase letter, one lowercase letter, one number, and one special character."
}

variable "kms_key_alias" {
  description = "The alias of the kms key required to decrypt the encrypted payload and render files for booscripts. This populates a data source to find th required key."
}

variable "encrypted_password_payload" {
  description = "The encrypted payload containing the password, this is required to decrypt dynamically to redact the value within console outputs."
}

variable "vpc_id" {

}

variable "subnet_ids" {

}

variable "sg_ingress_cidr_blocks" {
  default = []
}

variable "create_iam_service_linked_role" {
  type        = string
  default     = "false"
  description = "Whether to create `AWSServiceRoleForAmazonElasticsearchService` service-linked role. Set it to `false` if you already have an ElasticSearch cluster created in the AWS account and AWSServiceRoleForAmazonElasticsearchService already exists. See https://github.com/terraform-providers/terraform-provider-aws/issues/5218 for more info"
}
