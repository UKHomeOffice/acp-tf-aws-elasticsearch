variable "domain_name" {
  
}

variable "elasticsearch_version" {
  
}

variable "data_instance_type" {
  
}

variable "data_instance_count" {
  
}

variable "master_enabled" {
  default = false 
  description = "Boolean value to enable/disable dedicated master nodes."
}

variable "master_instance_count" {
  default = 0
  description = "The amount of dedicated master nodes within the cluster."
}

variable "master_instance_type" {
  default = ""
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
  default = []
}

variable "index_list" {
  description = "List of indexes to be created in Elasticsearch."
  default = []
}

variable "index_shard_count" {
  description = "Updates the index template to define the amount of shards set for all indices."
  default = "1"
}

variable "index_refresh_interval" {
  description = "Updates the index template to define the interval between each index refresh."
  default = "30s"
}

variable "index_replica_count" {
  description = "Updates the index template to define the amount of replica shards set for all indices."
  default = "1"
}

variable "index_rollover_size" {
  description = "Updates the ISM policy with the index size limit before triggering the rollover action."
  default = "75gb"
}

variable "index_rollover_age" {
  description = "Updates the ISM policy with the index age limit before triggering the rollover action."
  default = "1d"
}

variable "index_retention" {
  description = "Updates the ISM policy with the index retention time before being deleted."
  default = "7d"
}

variable "logstash_username" {
  description = "Logstash username in Kibana RBAC"
  default = "logstash-acp"
}

variable "logstash_password" {
  description = "Logstash password in Kibana RBAC"
}

variable "logstash_permissions" {
  description = "Logstash index level permissions. Due to predefined permissions in template, this requires escaped double quotes followed by a trailing comma for JSON object e.g \"read\","
  default = ""
}

variable "proxy_username" {
  description = "Proxy username in Kibana RBAC"
  default = "auth-proxy"
}

variable "proxy_password" {
  description = "Proxy password in Kibana RBAC"
}

variable "proxy_cluster_permissions" {
  description = "Proxy cluster-level permissions"
  default = ""
}

variable "master_user_name" {
  
}

variable "master_user_password" {
  description = "The master user password must contain at least one uppercase letter, one lowercase letter, one number, and one special character."
}

variable "vpc_id" {
  
}

variable "subnet_ids" {
  
}

variable "sg_ingress_cidr" {
  default = ""
}

variable "create_iam_service_linked_role" {
  type        = string
  default     = "false"
  description = "Whether to create `AWSServiceRoleForAmazonElasticsearchService` service-linked role. Set it to `false` if you already have an ElasticSearch cluster created in the AWS account and AWSServiceRoleForAmazonElasticsearchService already exists. See https://github.com/terraform-providers/terraform-provider-aws/issues/5218 for more info"
}
