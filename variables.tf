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
  description = "The master user password must contain at least one uppercase letter, one lowercase letter, one number, and one special character."
}

variable "vpc_id" {
  
}

variable "subnet_ids" {
  
}

variable "sg_ingress_cidr" {
  default = "10.250.0.0/18"
}
