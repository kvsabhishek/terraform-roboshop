resource "aws_vpc" "vpc" {
  for_each             = var.vpc_cidrs
  cidr_block           = each.value
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${each.key}"
  }
}

resource "aws_subnet" "vpc1_public" {
  count                   = length(var.vpc1_public_subnets)
  vpc_id                  = aws_vpc.vpc["vpc1"].id
  cidr_block              = var.vpc1_public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.azs[count.index]

  tags = {
    Name = "vpc1-public-${var.azs[count.index]}"
  }
}

resource "aws_subnet" "vpc1_private" {
  count             = length(var.vpc1_private_subnets)
  vpc_id            = aws_vpc.vpc["vpc1"].id
  cidr_block        = var.vpc1_private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "vpc1-private-${var.azs[count.index]}"
  }
}

resource "aws_subnet" "vpc2_public" {
  count                   = length(var.vpc2_public_subnets)
  vpc_id                  = aws_vpc.vpc["vpc2"].id
  cidr_block              = var.vpc2_public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.azs[count.index]

  tags = {
    Name = "vpc2-public-${var.azs[count.index]}"
  }
}

resource "aws_subnet" "vpc2_private" {
  count             = length(var.vpc2_private_subnets)
  vpc_id            = aws_vpc.vpc["vpc2"].id
  cidr_block        = var.vpc2_private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "vpc2-private-${var.azs[count.index]}"
  }
}

resource "aws_subnet" "vpc2_database" {
  count             = length(var.vpc2_database_subnets)
  vpc_id            = aws_vpc.vpc["vpc2"].id
  cidr_block        = var.vpc2_database_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "vpc2-database-${var.azs[count.index]}"
  }
}

resource "aws_internet_gateway" "vpc1_igw" {
  count  = length(var.vpc1_public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.vpc["vpc1"].id

  tags = {
    Name = "vpc1-igw"
  }
}

resource "aws_internet_gateway" "vpc2_igw" {
  count  = length(var.vpc2_public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.vpc["vpc2"].id

  tags = {
    Name = "vpc2-igw"
  }
}

resource "aws_eip" "vpc1_eip" {
  count = length(var.vpc1_private_subnets) > 0 ? 1 : 0

  tags = {
    Name = "vpc1-eip"
  }
}

resource "aws_eip" "vpc2_eip" {
  count = length(var.vpc2_private_subnets) > 0 || length(var.vpc2_database_subnets) > 0 ? 1 : 0

  tags = {
    Name = "vpc2-eip"
  }
}

resource "aws_nat_gateway" "vpc1" {
  count         = length(aws_subnet.vpc1_private)
  allocation_id = aws_eip.vpc1_eip[0].id

  subnet_id = aws_subnet.vpc1_private[count.index].id
}

resource "aws_nat_gateway" "vpc2" {
  count         = length(concat(aws_subnet.vpc2_private, aws_subnet.vpc2_database))
  allocation_id = aws_eip.vpc2_eip[0].id

  subnet_id = concat(aws_subnet.vpc2_private, aws_subnet.vpc2_database)[count.index].id
}
