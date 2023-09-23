resource "aws_subnet" "vpc1_public" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.vpc1_public_cidr
  map_public_ip_on_launch = true
}

resource "aws_subnet" "vpc2_public" {
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = var.vpc2_public_cidr
  map_public_ip_on_launch = true
}

resource "aws_subnet" "vpc2_private" {
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = var.vpc2_private_cidr
  map_public_ip_on_launch = false
}
