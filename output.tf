output "elasticseach_instance_type" {
  value = aws_elasticsearch_domain.cluster.cluster_config[0].instance_type
}
