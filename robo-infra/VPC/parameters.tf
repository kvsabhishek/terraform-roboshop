resource "aws_ssm_parameter" "vpc1_id" {
  name  = "vpc1_id"
  type  = "String"
  value = aws_vpc.vpc["vpc1"].id
}

resource "aws_ssm_parameter" "vpc2_id" {
  name  = "vpc2_id"
  type  = "String"
  value = aws_vpc.vpc["vpc2"].id
}

resource "aws_ssm_parameter" "vpc1_cidr" {
  name  = "vpc1_cidr"
  type  = "String"
  value = aws_vpc.vpc["vpc1"].cidr_block
}

resource "aws_ssm_parameter" "vpc2_cidr" {
  name  = "vpc2_cidr"
  type  = "String"
  value = aws_vpc.vpc["vpc2"].cidr_block
}

resource "aws_ssm_parameter" "vpc1_public_subnet_ids" {
  count = length(aws_subnet.vpc1_public)
  name  = "${aws_subnet.vpc1_public[count.index].tags.Name}-subnet-id"
  type  = "String"
  value = aws_subnet.vpc1_public[count.index].id
}

resource "aws_ssm_parameter" "vpc1_private_subnet_ids" {
  count = length(aws_subnet.vpc1_private)
  name  = "${aws_subnet.vpc1_private[count.index].tags.Name}-subnet-id"
  type  = "String"
  value = aws_subnet.vpc1_private[count.index].id
}

resource "aws_ssm_parameter" "vpc1_database_subnet_ids" {
  count = length(aws_subnet.vpc1_database)
  name  = "${aws_subnet.vpc1_database[count.index].tags.Name}-subnet-id"
  type  = "String"
  value = aws_subnet.vpc1_database[count.index].id
}

resource "aws_ssm_parameter" "vpc2_public_subnet_ids" {
  count = length(aws_subnet.vpc2_public)
  name  = "${aws_subnet.vpc2_public[count.index].tags.Name}-subnet-id"
  type  = "String"
  value = aws_subnet.vpc2_public[count.index].id
}

resource "aws_ssm_parameter" "vpc2_private_subnet_ids" {
  count = length(aws_subnet.vpc2_private)
  name  = "${aws_subnet.vpc2_private[count.index].tags.Name}-subnet-id"
  type  = "String"
  value = aws_subnet.vpc2_private[count.index].id
}

resource "aws_ssm_parameter" "vpc2_database_subnet_ids" {
  count = length(aws_subnet.vpc2_database)
  name  = "${aws_subnet.vpc2_database[count.index].tags.Name}-subnet-id"
  type  = "String"
  value = aws_subnet.vpc2_database[count.index].id
}

resource "aws_ssm_parameter" "vpc1_route_tables" {
  for_each = local.vpc1_route_tables_id
  name     = each.key
  type     = "String"
  value    = each.value
}

resource "aws_ssm_parameter" "vpc2_route_tables" {
  for_each = local.vpc2_route_tables_id
  name     = each.key
  type     = "String"
  value    = each.value
}
