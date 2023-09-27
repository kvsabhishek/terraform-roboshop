resource "aws_route" "vpc1_public" {
  route_table_id         = data.aws_ssm_parameter.vpc1_public_route.value
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = data.aws_ssm_parameter.vpc1_gateway.value
}

resource "aws_route" "vpc2_public" {
  route_table_id         = data.aws_ssm_parameter.vpc2_public_route.value
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = data.aws_ssm_parameter.vpc2_gateway.value
}

resource "aws_eip" "vpc2_eip" {

}

resource "aws_nat_gateway" "vpc2_nat" {
  allocation_id = aws_eip.vpc2_eip.id
  subnet_id     = data.aws_ssm_parameter.vpc2_private_subnet_id.value
}

resource "aws_route" "vpc2_private_route" {
  route_table_id         = data.aws_ssm_parameter.vpc2_private_route.value
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.vpc2_nat.id
}

resource "aws_route" "vpc2_database_route" {
  route_table_id         = data.aws_ssm_parameter.vpc2_database_route.value
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.vpc2_nat.id
}
