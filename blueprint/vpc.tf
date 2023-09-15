resource "aws_vpc" "roboshop_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge({ Name = "${var.project_name}-vpc" }, var.common_tags)
}
