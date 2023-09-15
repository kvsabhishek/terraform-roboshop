resource "aws_subnet" "public" {
  for_each = var.public_subnet

  vpc_id            = aws_vpc.roboshop_vpc.id
  availability_zone = each.key
  cidr_block        = each.value
  tags              = merge({ Name = "${var.project_name}-public_subnet-${each.key}" }, var.common_tags)
}

resource "aws_subnet" "private" {
  for_each = var.private_subnet

  vpc_id            = aws_vpc.roboshop_vpc.id
  availability_zone = each.key
  cidr_block        = each.value
  tags              = merge({ Name = "${var.project_name}-private_subnet-${each.key}" }, var.common_tags)
}
