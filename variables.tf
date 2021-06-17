variable "domain_name" {
  
}

variable "elasticsearch_version" {
  
}

variable "instance_type" {
  
}

variable "instance_count" {
  
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
    default = "gp2"
}
    
variable "volume_size" {
    default = 10
}

variable "master_user_name" {
  
}

variable "master_user_password" {
  
}
