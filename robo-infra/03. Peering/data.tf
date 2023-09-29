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

data "aws_ssm_parameter" "vpc1_id" {
  name = "/${var.project_name}/${var.environment}/vpc-1_id"
}

data "aws_ssm_parameter" "vpc2_id" {
  name = "/${var.project_name}/${var.environment}/vpc-2_id"
}

data "aws_ssm_parameter" "vpc1_cidr" {
  name = "/${var.project_name}/${var.environment}/vpc-1"
}

data "aws_ssm_parameter" "vpc2_cidr" {
  name = "/${var.project_name}/${var.environment}/vpc-2"
}
