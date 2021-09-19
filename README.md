# acp-tf-aws-elasticsearch
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.es_domain_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_resource_policy.es_log_group_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_resource_policy) | resource |
| [aws_elasticsearch_domain.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain) | resource |
| [aws_elasticsearch_domain_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain_policy) | resource |
| [aws_iam_service_linked_role.es](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |
| [aws_security_group.es](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [local_file.indices_script](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.script](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.service_users_script](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.tenants_script](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.bootstrap_service_users](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.create_cluster_indices](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.create_cluster_tenants](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.create_local_users](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [time_sleep.wait_60_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_users"></a> [admin\_users](#input\_admin\_users) | group of users to be created in kibana. | `list` | `[]` | no |
| <a name="input_automated_snapshot_start_hour"></a> [automated\_snapshot\_start\_hour](#input\_automated\_snapshot\_start\_hour) | n/a | `number` | `23` | no |
| <a name="input_create_iam_service_linked_role"></a> [create\_iam\_service\_linked\_role](#input\_create\_iam\_service\_linked\_role) | Whether to create `AWSServiceRoleForAmazonElasticsearchService` service-linked role. Set it to `false` if you already have an ElasticSearch cluster created in the AWS account and AWSServiceRoleForAmazonElasticsearchService already exists. See https://github.com/terraform-providers/terraform-provider-aws/issues/5218 for more info | `string` | `"false"` | no |
| <a name="input_data_instance_count"></a> [data\_instance\_count](#input\_data\_instance\_count) | n/a | `any` | n/a | yes |
| <a name="input_data_instance_type"></a> [data\_instance\_type](#input\_data\_instance\_type) | n/a | `any` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | n/a | `any` | n/a | yes |
| <a name="input_ebs_enabled"></a> [ebs\_enabled](#input\_ebs\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_elasticsearch_version"></a> [elasticsearch\_version](#input\_elasticsearch\_version) | n/a | `any` | n/a | yes |
| <a name="input_encrypt_at_rest_enabled"></a> [encrypt\_at\_rest\_enabled](#input\_encrypt\_at\_rest\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_large_index_list"></a> [large\_index\_list](#input\_large\_index\_list) | List of larger sized indexes to be created in Elasticsearch. e.g expected 1TB per day | `list` | `[]` | no |
| <a name="input_large_index_refresh_interval"></a> [large\_index\_refresh\_interval](#input\_large\_index\_refresh\_interval) | Updates the large index template to define the interval between each index refresh. | `string` | `"30s"` | no |
| <a name="input_large_index_replica_count"></a> [large\_index\_replica\_count](#input\_large\_index\_replica\_count) | Updates the large index template to define the amount of replica shards set for all indices. | `string` | `"1"` | no |
| <a name="input_large_index_retention"></a> [large\_index\_retention](#input\_large\_index\_retention) | Updates the ISM policy with the index retention time before being deleted. | `string` | `"7d"` | no |
| <a name="input_large_index_rollover_age"></a> [large\_index\_rollover\_age](#input\_large\_index\_rollover\_age) | Updates the large ISM policy with the index age limit before triggering the rollover action. | `string` | `"1d"` | no |
| <a name="input_large_index_rollover_size"></a> [large\_index\_rollover\_size](#input\_large\_index\_rollover\_size) | Updates the large ISM policy with the index size limit before triggering the rollover action. | `string` | `"600gb"` | no |
| <a name="input_large_index_shard_count"></a> [large\_index\_shard\_count](#input\_large\_index\_shard\_count) | Updates the large index template to define the amount of shards set for all indices. | `string` | `"12"` | no |
| <a name="input_logstash_cluster_permissions"></a> [logstash\_cluster\_permissions](#input\_logstash\_cluster\_permissions) | Logstash cluster-level permissions. | `list` | <pre>[<br>  "cluster:admin/ingest/pipeline/get",<br>  "cluster:admin/ingest/pipeline/put",<br>  "cluster_monitor",<br>  "indices:data/write/bulk",<br>  "indices:data/write/bulk*",<br>  "indices:data/write/index",<br>  "indices:admin/mapping/put"<br>]</pre> | no |
| <a name="input_logstash_index_permissions"></a> [logstash\_index\_permissions](#input\_logstash\_index\_permissions) | Logstash index-level permissions. | `list` | <pre>[<br>  "read",<br>  "get",<br>  "indices:data/write/bulk",<br>  "indices:data/write/bulk*",<br>  "indices:data/write/index",<br>  "indices:admin/mapping/put",<br>  "indices:monitor/settings/get",<br>  "indices:monitor/stats"<br>]</pre> | no |
| <a name="input_logstash_password"></a> [logstash\_password](#input\_logstash\_password) | Logstash password in Kibana RBAC | `string` | `""` | no |
| <a name="input_logstash_username"></a> [logstash\_username](#input\_logstash\_username) | Logstash username in Kibana RBAC | `string` | `""` | no |
| <a name="input_master_enabled"></a> [master\_enabled](#input\_master\_enabled) | Boolean value to enable/disable dedicated master nodes. | `bool` | `false` | no |
| <a name="input_master_instance_count"></a> [master\_instance\_count](#input\_master\_instance\_count) | The amount of dedicated master nodes within the cluster. | `number` | `0` | no |
| <a name="input_master_instance_type"></a> [master\_instance\_type](#input\_master\_instance\_type) | The instance type for the dedicated master nodes. | `string` | `""` | no |
| <a name="input_master_user_name"></a> [master\_user\_name](#input\_master\_user\_name) | n/a | `any` | n/a | yes |
| <a name="input_master_user_password"></a> [master\_user\_password](#input\_master\_user\_password) | The master user password must contain at least one uppercase letter, one lowercase letter, one number, and one special character. | `any` | n/a | yes |
| <a name="input_medium_index_list"></a> [medium\_index\_list](#input\_medium\_index\_list) | List of medium sized indexes to be created in Elasticsearch. e.g 30GB per day | `list` | `[]` | no |
| <a name="input_medium_index_refresh_interval"></a> [medium\_index\_refresh\_interval](#input\_medium\_index\_refresh\_interval) | Updates the medium index template to define the interval between each index refresh. | `string` | `"30s"` | no |
| <a name="input_medium_index_replica_count"></a> [medium\_index\_replica\_count](#input\_medium\_index\_replica\_count) | Updates the medium index template to define the amount of replica shards set for all indices. | `string` | `"1"` | no |
| <a name="input_medium_index_retention"></a> [medium\_index\_retention](#input\_medium\_index\_retention) | Updates the medium ISM policy with the index retention time before being deleted. | `string` | `"7d"` | no |
| <a name="input_medium_index_rollover_age"></a> [medium\_index\_rollover\_age](#input\_medium\_index\_rollover\_age) | Updates the medium ISM policy with the index age limit before triggering the rollover action. | `string` | `"1d"` | no |
| <a name="input_medium_index_rollover_size"></a> [medium\_index\_rollover\_size](#input\_medium\_index\_rollover\_size) | Updates the medium ISM policy with the index size limit before triggering the rollover action. | `string` | `"300gb"` | no |
| <a name="input_medium_index_shard_count"></a> [medium\_index\_shard\_count](#input\_medium\_index\_shard\_count) | Updates the medium index template to define the amount of shards set for all indices. | `string` | `"6"` | no |
| <a name="input_proxy_cluster_permissions"></a> [proxy\_cluster\_permissions](#input\_proxy\_cluster\_permissions) | Proxy cluster-level permissions | `list` | `[]` | no |
| <a name="input_proxy_index_permissions"></a> [proxy\_index\_permissions](#input\_proxy\_index\_permissions) | Proxy index-level permissions | `list` | `[]` | no |
| <a name="input_proxy_password"></a> [proxy\_password](#input\_proxy\_password) | Proxy password in Kibana RBAC | `string` | `""` | no |
| <a name="input_proxy_username"></a> [proxy\_username](#input\_proxy\_username) | Proxy username in Kibana RBAC | `string` | `""` | no |
| <a name="input_sg_ingress_cidr_blocks"></a> [sg\_ingress\_cidr\_blocks](#input\_sg\_ingress\_cidr\_blocks) | n/a | `list` | `[]` | no |
| <a name="input_small_index_list"></a> [small\_index\_list](#input\_small\_index\_list) | List of small sized indexes to be created in Elasticsearch. e.g expected 5GB per day | `list` | `[]` | no |
| <a name="input_small_index_refresh_interval"></a> [small\_index\_refresh\_interval](#input\_small\_index\_refresh\_interval) | Updates the small index template to define the interval between each index refresh. | `string` | `"30s"` | no |
| <a name="input_small_index_replica_count"></a> [small\_index\_replica\_count](#input\_small\_index\_replica\_count) | Updates the small index template to define the amount of replica shards set for all indices. | `string` | `"1"` | no |
| <a name="input_small_index_retention"></a> [small\_index\_retention](#input\_small\_index\_retention) | Updates the ISM policy with the index retention time before being deleted. | `string` | `"7d"` | no |
| <a name="input_small_index_rollover_age"></a> [small\_index\_rollover\_age](#input\_small\_index\_rollover\_age) | Updates the small ISM policy with the index age limit before triggering the rollover action. | `string` | `"1d"` | no |
| <a name="input_small_index_rollover_size"></a> [small\_index\_rollover\_size](#input\_small\_index\_rollover\_size) | Updates the small ISM policy with the index size limit before triggering the rollover action. | `string` | `"30gb"` | no |
| <a name="input_small_index_shard_count"></a> [small\_index\_shard\_count](#input\_small\_index\_shard\_count) | Updates the small index template to define the amount of shards set for all indices. | `string` | `"1"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_tenant_list"></a> [tenant\_list](#input\_tenant\_list) | List of tenant names to be provisioned in Elasticsearch. | `list` | `[]` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | n/a | `number` | `0` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | n/a | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
