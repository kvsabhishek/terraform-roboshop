locals {
  availability_zones = tolist(data.aws_availability_zones.available.names)

  vpc1_public_az   = slice(local.availability_zones, 0, length(var.vpc1_public_subnets))
  vpc1_private_az  = slice(local.availability_zones, 0, length(var.vpc1_private_subnets))
  vpc1_database_az = slice(local.availability_zones, 0, length(var.vpc1_database_subnets))

  vpc2_public_az   = slice(local.availability_zones, 0, length(var.vpc2_public_subnets))
  vpc2_private_az  = slice(local.availability_zones, 0, length(var.vpc2_private_subnets))
  vpc2_database_az = slice(local.availability_zones, 0, length(var.vpc2_database_subnets))

  vpc2_private_subnets = concat(aws_subnet.vpc2_private, aws_subnet.vpc2_database)

  vpc1_subnets = concat(aws_subnet.vpc1_public, aws_subnet.vpc1_private, aws_subnet.vpc1_database)
  vpc2_subnets = concat(aws_subnet.vpc2_public, aws_subnet.vpc2_private, aws_subnet.vpc2_database)
}
