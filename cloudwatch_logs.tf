resource "aws_cloudwatch_log_group" "es_domain_log_group" {
  name = "es-${var.domain_name}"

  tags = var.tags
}

resource "aws_cloudwatch_log_resource_policy" "es_log_group_policy" {
  policy_name = "es-${var.domain_name}"

  policy_document = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "es.amazonaws.com"
      },
      "Action": [
        "logs:PutLogEvents",
        "logs:PutLogEventsBatch",
        "logs:CreateLogStream"
      ],
      "Resource": "arn:aws:logs:*"
    }
  ]
}
CONFIG
}
