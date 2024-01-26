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
  for_each                = local.vpc1_public_cidrs
  vpc_id                  = aws_vpc.vpc["vpc1"].id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = "vpc1-public-${each.key}"
    },
    var.common_tags
  )
}

resource "aws_subnet" "vpc1_private" {
  for_each                   = local.vpc1_private_cidrs
  vpc_id                  = aws_vpc.vpc["vpc1"].id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = false

  tags = merge(
    {
      Name = "vpc1-private-${each.key}"
    },
    var.common_tags
  )
}

resource "aws_subnet" "vpc1_database" {
  for_each                   = local.vpc1_database_cidrs
  vpc_id                  = aws_vpc.vpc["vpc1"].id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = false

  tags = merge(
    {
      Name = "vpc1-database-${each.key}"
    },
    var.common_tags
  )
}

resource "aws_subnet" "vpc2_public" {
  for_each                = local.vpc2_public_cidrs
  vpc_id                  = aws_vpc.vpc["vpc2"].id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = "vpc2-public-${each.key]}"
    },
    var.common_tags
  )
}

resource "aws_subnet" "vpc2_private" {
  for_each                   = local.vpc2_private_cidrs
  vpc_id                  = aws_vpc.vpc["vpc2"].id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = false

  tags = merge(
    {
      Name = "vpc2-private-${each.key}"
    },
    var.common_tags
  )
}

resource "aws_subnet" "vpc2_database" {
  count                   = length(local.vpc2_database_az)
  vpc_id                  = aws_vpc.vpc["vpc2"].id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = false

  tags = merge(
    {
      Name = "vpc2-database-${each.key}"
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
  count = length(local.vpc2_private_subnets) > 0 ? 1 : 0
}

resource "aws_nat_gateway" "vpc2_nat" {
  count         = length(local.vpc2_private_subnets) > 0 ? 1 : 0
  allocation_id = aws_eip.vpc2[0].id
  subnet_id     = aws_subnet.vpc2_public[0].id

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

resource "aws_route" "vpc1_pubilic_route" {
  count                  = length(aws_subnet.vpc1_public)
  route_table_id         = aws_route_table.vpc1_route[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc_igw["vpc1"].id
}

resource "aws_route" "vpc2_pubilic_route" {
  count                  = length(aws_subnet.vpc2_public)
  route_table_id         = aws_route_table.vpc2_route[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc_igw["vpc2"].id
}

# resource "aws_route" "vpc2_private_route" {
#   count          = length(local.vpc2_private_subnets)
#   route_table_id = aws_route_table.vpc2_route

# }
