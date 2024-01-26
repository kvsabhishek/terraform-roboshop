locals {
  availability_zones = tolist(data.aws_availability_zones.available.names)

  vpc1_public_az      = slice(local.availability_zones, 0, length(var.vpc1_public_subnets))
  vpc1_public_cidrs   = { for i in range(0, length(var.vpc1_public_subnets)) : "${local.vpc1_public_az[i]}" => var.vpc1_public_subnets[i] }
  vpc1_private_az     = slice(local.availability_zones, 0, length(var.vpc1_private_subnets))
  vpc1_private_cidrs  = { for i in range(0, length(var.vpc1_private_subnets)) : "${local.vpc1_private_az[i]}" => var.vpc1_private_subnets[i] }
  vpc1_database_az    = slice(local.availability_zones, 0, length(var.vpc1_database_subnets))
  vpc1_database_cidrs = { for i in range(0, length(var.vpc1_database_subnets)) : "${local.vpc1_database_az[i]}" => var.vpc1_database_subnets[i] }

  vpc2_public_az      = slice(local.availability_zones, 0, length(var.vpc2_public_subnets))
  vpc2_public_cidrs   = { for i in range(0, length(var.vpc2_public_subnets)) : "${local.vpc2_public_az[i]}" => var.vpc2_public_subnets[i] }
  vpc2_private_az     = slice(local.availability_zones, 0, length(var.vpc2_private_subnets))
  vpc2_private_cidrs  = { for i in range(0, length(var.vpc2_private_subnets)) : "${local.vpc2_private_az[i]}" => var.vpc2_private_subnets[i] }
  vpc2_database_az    = slice(local.availability_zones, 0, length(var.vpc2_database_subnets))
  vpc2_database_cidrs = { for i in range(0, length(var.vpc2_database_subnets)) : "${local.vpc2_database_az[i]}" => var.vpc2_database_subnets[i] }
}
