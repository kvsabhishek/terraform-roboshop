data "aws_ssm_parameter" "vpc1_public_route" {
  name = "/${var.project_name}/${var.environment}/vpc-1/public-route_table_id"
}

data "aws_ssm_parameter" "vpc1_private_route" {
  name = "/${var.project_name}/${var.environment}/vpc-1/private-route_table_id"
}

data "aws_ssm_parameter" "vpc2_public_route" {
  name = "/${var.project_name}/${var.environment}/vpc-2/public-route_table_id"
}

data "aws_ssm_parameter" "vpc2_private_route" {
  name = "/${var.project_name}/${var.environment}/vpc-2/private-route_table_id"
}

data "aws_ssm_parameter" "vpc2_database_route" {
  name = "/${var.project_name}/${var.environment}/vpc-2/database-route_table_id"
}

data "aws_ssm_parameter" "vpc1_public_cidr" {
  name = "/${var.project_name}/${var.environment}/vpc-1/public-cidr"
}

data "aws_ssm_parameter" "vpc1_private_cidr" {
  name = "/${var.project_name}/${var.environment}/vpc-1/public-cidr"
}

data "aws_ssm_parameter" "vpc2_public_cidr" {
  name = "/${var.project_name}/${var.environment}/vpc-2/public-cidr"
}

data "aws_ssm_parameter" "vpc2_private_cidr" {
  name = "/${var.project_name}/${var.environment}/vpc-2/private-cidr"
}

data "aws_ssm_parameter" "vpc2_database_cidr" {
  name = "/${var.project_name}/${var.environment}/vpc-2/database-cidr"
}

data "aws_ssm_parameter" "vpc1_gateway" {
  name = "/${var.project_name}/${var.environment}/vpc-1/internet_gateway_id"
}

data "aws_ssm_parameter" "vpc2_gateway" {
  name = "/${var.project_name}/${var.environment}/vpc-2/internet_gateway_id"
}

data "aws_ssm_parameter" "vpc1_public_subnet_id" {
  name = "/${var.project_name}/${var.environment}/vpc-1/public-subnet_id"
}

data "aws_ssm_parameter" "vpc1_private_subnet_id" {
  name = "/${var.project_name}/${var.environment}/vpc-1/private-subnet_id"
}

data "aws_ssm_parameter" "vpc2_public_subnet_id" {
  name = "/${var.project_name}/${var.environment}/vpc-2/public-subnet_id"
}

data "aws_ssm_parameter" "vpc2_private_subnet_id" {
  name = "/${var.project_name}/${var.environment}/vpc-2/private-subnet_id"
}

data "aws_ssm_parameter" "vpc2_database_subnet_id" {
  name = "/${var.project_name}/${var.environment}/vpc-2/database-subnet_id"
}
