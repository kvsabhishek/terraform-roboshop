module "roboshop" {
  source = "../blueprint"

  # VPC
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr

  # PUBLIC SUBNET
  public_subnet = var.public_subnet
}
