resource "aws_ssm_parameter" "vpc1_cidr" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/vpc1_cidr"
  value = var.vpc1_cidr
}

resource "aws_ssm_parameter" "vpc2_cidr" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/vpc2_cidr"
  value = var.vpc2_cidr
}

resource "aws_ssm_parameter" "vpc1_igw_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/vpc1_igw.id"
  value = aws_internet_gateway.vpc1.id
}

resource "aws_ssm_parameter" "vpc2_igw_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/vpc2_igw.id"
  value = aws_internet_gateway.vpc2.id
}

resource "aws_ssm_parameter" "vpc1_route" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/vpc1_route"
  value = aws_vpc.vpc1.main_route_table_id
}

resource "aws_ssm_parameter" "vpc2_route" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/vpc2_route"
  value = aws_vpc.vpc2.main_route_table_id
}
