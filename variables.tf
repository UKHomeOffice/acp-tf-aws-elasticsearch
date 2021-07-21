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
  default = ["alastair", "willem"]
}

variable "clusters" {
  description = "group of users to be created in kibana."
  default = []
}

variable "logstash_username" {
  description = "Logstash username in Kibana RBAC"
  default = "logstash-acp"
}

variable "logstash_password" {
  description = "Logstash password in Kibana RBAC"
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
  default = "['a', 'b']"
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
  default = "10.250.0.0/18"
}

variable "create_iam_service_linked_role" {
  type        = string
  default     = "false"
  description = "Whether to create `AWSServiceRoleForAmazonElasticsearchService` service-linked role. Set it to `false` if you already have an ElasticSearch cluster created in the AWS account and AWSServiceRoleForAmazonElasticsearchService already exists. See https://github.com/terraform-providers/terraform-provider-aws/issues/5218 for more info"
}