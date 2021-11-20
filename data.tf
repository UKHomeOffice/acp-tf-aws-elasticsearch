data "aws_kms_key" "key" {
  key_id = "alias/${var.kms_key_alias}"
}