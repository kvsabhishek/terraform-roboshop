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

# resource "aws_vpc_peering_connection" "vpc1_vpc2" {
#   peer_vpc_id = module.vpc
# }
