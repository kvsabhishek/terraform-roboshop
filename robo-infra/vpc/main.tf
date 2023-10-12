resource "aws_vpc" "vpc" {
  for_each = var.vpc_cidrs

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
  cidr_block              = var.vpc1_public_subnets[count.index]
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
  cidr_block              = var.vpc1_private_subnets[count.index]
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
  cidr_block              = var.vpc1_database_subnets[count.index]
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
  cidr_block              = var.vpc2_public_subnets[count.index]
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
  cidr_block              = var.vpc2_private_subnets[count.index]
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
  cidr_block              = var.vpc2_database_subnets[count.index]
  availability_zone       = local.vpc2_database_az[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    {
      Name = "vpc2-database-${local.vpc2_database_az[count.index]}"
    },
    var.common_tags
  )
}

resource "aws_internet_gateway" "vpc_igw" {
  for_each = aws_vpc.vpc
  vpc_id   = each.value.id

  tags = merge({
    Name = "${each.key}-igw"
    },
    var.common_tags
  )
}

resource "aws_eip" "vpc2" {
  count = length(local.vpc2_private_subnets)
}

resource "aws_nat_gateway" "vpc2_nat" {
  count         = length(local.vpc2_private_subnets)
  allocation_id = aws_eip.vpc2[count.index].id
  subnet_id     = local.vpc2_private_subnets[count.index].id

  tags = merge({
    Name = "vpc2-nat"
    },
    var.common_tags
  )
}


resource "aws_route_table" "vpc1_route" {
  count  = length(local.vpc1_subnets)
  vpc_id = aws_vpc.vpc["vpc1"].id

  tags = merge({
    Name = "${local.vpc1_subnets[count.index].tags.Name}-table"
    },
    var.common_tags
  )
}

resource "aws_route_table" "vpc2_route" {
  count  = length(local.vpc2_subnets)
  vpc_id = aws_vpc.vpc["vpc2"].id

  tags = merge({
    Name = "${local.vpc2_subnets[count.index].tags.Name}-table"
    },
    var.common_tags
  )
}


resource "aws_route_table_association" "vpc1_route" {
  count          = length(local.vpc1_subnets)
  subnet_id      = local.vpc1_subnets[count.index].id
  route_table_id = aws_route_table.vpc1_route[count.index].id
}

resource "aws_route_table_association" "vpc2_route" {
  count          = length(local.vpc2_subnets)
  subnet_id      = local.vpc2_subnets[count.index].id
  route_table_id = aws_route_table.vpc2_route[count.index].id
}
