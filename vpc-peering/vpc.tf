resource "aws_vpc" "vpc1" {
  cidr_block           = var.vpc1_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = merge(
    var.common_tags,
    {
      Name = "VPC-1"
    }
  )
}

resource "aws_vpc" "vpc2" {
  cidr_block = var.vpc2_cidr
  tags = merge(
    var.common_tags,
    {
      Name = "VPC-2"
    }
  )
}
