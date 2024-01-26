module "vpc_infra" {
  source                = "../VPC"
  vpc_cidrs             = var.vpc_cidrs
  vpc1_public_subnets   = var.vpc1_public_subnets
  vpc1_private_subnets  = var.vpc1_private_subnets
  vpc1_database_subnets = var.vpc1_database_subnets
  vpc2_public_subnets   = var.vpc2_public_subnets
  vpc2_private_subnets  = var.vpc2_private_subnets
  vpc2_database_subnets = var.vpc2_database_subnets
  common_tags           = var.common_tags
}

resource "aws_vpc_peering_connection" "vpc1_vpc2" {
  peer_vpc_id = data.aws_ssm_parameter.vpc1_id.value
  vpc_id      = data.aws_ssm_parameter.vpc2_id.value
  auto_accept = true
}

resource "aws_route" "vcp1_public_routes" {
  for_each                  = module.vpc_infra.vpc1_route_tables_id
  destination_cidr_block    = var.vpc_cidrs["vpc2"]
  route_table_id            = each.value
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc1_vpc2.id
}

resource "aws_route" "vcp2_public_routes" {
  for_each                  = module.vpc_infra.vpc2_route_tables_id
  destination_cidr_block    = var.vpc_cidrs["vpc1"]
  route_table_id            = each.value
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc1_vpc2.id
}





