data "template_file" "user_script" {
  template = file("${path.module}/files/create_local_users.sh")
  vars = {
    local_users = var.local_users
    master_user_name = var.master_user_name
    master_user_password = var.master_user_password
    aws_es_endpoint = aws_elasticsearch_domain.cluster.endpoint
  }
}