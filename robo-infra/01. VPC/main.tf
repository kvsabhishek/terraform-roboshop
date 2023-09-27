resource "aws_vpc" "vpc" {
  for_each   = var.vpc_cidrs
  cidr_block = each.value
  tags = merge(var.common_tags,
    {
      Name = each.key
    }
  )
}

resource "aws_subnet" "vpc1" {
  for_each   = var.vpc1_subnet_cidrs
  cidr_block = each.value
  vpc_id     = aws_vpc.vpc[local.vpc_list[0]].id

  tags = merge(var.common_tags,
    {
      Name = "vpc1-${each.key}"
    }
  )
}

resource "aws_subnet" "vpc2" {
  for_each   = var.vpc2_subnet_cidrs
  cidr_block = each.value
  vpc_id     = aws_vpc.vpc[local.vpc_list[1]].id
  tags = merge(var.common_tags,
    {
      Name = "vpc2-${each.key}"
    }
  )
}

resource "aws_internet_gateway" "vpc" {
  for_each = aws_vpc.vpc
  vpc_id   = each.value.id
  tags = merge(
    var.common_tags,
    {
      Name = "${each.key}"
    }
  )
}

resource "aws_route_table" "vpc1" {
  for_each = var.vpc1_subnet_cidrs
  vpc_id   = aws_vpc.vpc[local.vpc_list[0]].id
  tags = merge(
    var.common_tags,
    {
      Name = "${each.key}"
    }
  )
}

resource "aws_route_table" "vpc2" {
  for_each = var.vpc2_subnet_cidrs
  vpc_id   = aws_vpc.vpc[local.vpc_list[1]].id
  tags = merge(
    var.common_tags,
    {
      Name = "${each.key}"
    }
  )
}
