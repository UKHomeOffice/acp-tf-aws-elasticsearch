resource "aws_security_group" "es" {
  name        = "elasticsearch-${var.domain_name}"
  description = "Managed by Terraform"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = [
      var.sg_ingress_cidr
    ]
  }
}
