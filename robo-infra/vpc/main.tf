resource "aws_vpc" "vpc" {
  for_each = local.vpc_cidr_list

  cidr_block           = each.value
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    {
      Name = each.key
    },
    var.common_tags
  )
}

resource "aws_subnet" "vpc1_public" {
  count                   = length(local.vpc1_public_az)
  vpc_id                  = aws_vpc.vpc["vpc1"].id
  cidr_block              = var.vpc1_public_subnet_cidrs[count.index]
  availability_zone       = local.vpc1_public_az[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = "vpc1-public-${local.vpc1_public_az[count.index]}"
    },
    var.common_tags
  )
}

resource "aws_subnet" "vpc1_private" {
  count                   = length(local.vpc1_private_az)
  vpc_id                  = aws_vpc.vpc["vpc1"].id
  cidr_block              = var.vpc1_private_subnet_cidrs[count.index]
  availability_zone       = local.vpc1_private_az[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    {
      Name = "vpc1-private-${local.vpc1_private_az[count.index]}"
    },
    var.common_tags
  )
}

resource "aws_subnet" "vpc1_database" {
  count                   = length(local.vpc1_database_az)
  vpc_id                  = aws_vpc.vpc["vpc1"].id
  cidr_block              = var.vpc1_database_subnet_cidrs[count.index]
  availability_zone       = local.vpc1_database_az[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    {
      Name = "vpc1-database-${local.vpc1_database_az[count.index]}"
    },
    var.common_tags
  )
}

resource "aws_subnet" "vpc2_public" {
  count                   = length(local.vpc2_public_az)
  vpc_id                  = aws_vpc.vpc["vpc2"].id
  cidr_block              = var.vpc2_public_subnet_cidrs[count.index]
  availability_zone       = local.vpc2_public_az[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = "vpc2-public-${local.vpc2_public_az[count.index]}"
    },
    var.common_tags
  )
}

resource "aws_subnet" "vpc2_private" {
  count                   = length(local.vpc2_private_az)
  vpc_id                  = aws_vpc.vpc["vpc2"].id
  cidr_block              = var.vpc2_private_subnet_cidrs[count.index]
  availability_zone       = local.vpc2_private_az[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    {
      Name = "vpc2-private-${local.vpc2_private_az[count.index]}"
    },
    var.common_tags
  )
}

resource "aws_subnet" "vpc2_database" {
  count                   = length(local.vpc2_database_az)
  vpc_id                  = aws_vpc.vpc["vpc2"].id
  cidr_block              = var.vpc2_database_subnet_cidrs[count.index]
  availability_zone       = local.vpc2_database_az[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    {
      Name = "vpc2-database-${local.vpc2_database_az[count.index]}"
    },
    var.common_tags
  )
}
