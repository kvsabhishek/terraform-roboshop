locals {
  vpc_cidr_list = { "vpc1" = var.vpc1_cidr, "vpc2" = var.vpc2_cidr }

  availability_zones = tolist(data.aws_availability_zones.available.names)

  vpc1_public_az   = slice(local.availability_zones, 0, var.vpc1_public_subnet_count)
  vpc1_private_az  = slice(local.availability_zones, 0, var.vpc1_private_subnet_count)
  vpc1_database_az = slice(local.availability_zones, 0, var.vpc1_database_subnet_count)

  vpc2_public_az   = slice(local.availability_zones, 0, var.vpc2_public_subnet_count)
  vpc2_private_az  = slice(local.availability_zones, 0, var.vpc2_private_subnet_count)
  vpc2_database_az = slice(local.availability_zones, 0, var.vpc2_database_subnet_count)
}
