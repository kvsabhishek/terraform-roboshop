module "roboshop" {
  source = "../blueprint"

  # VPC
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr

  # PUBLIC SUBNET
  public_subnet = var.public_subnet

  # PRIVATE SUBNET
  private_subnet = var.private_subnet



}
