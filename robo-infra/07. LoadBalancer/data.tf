data "aws_ssm_parameter" "alb_public_sg_id" {
  name = "/${var.project_name}/${var.environment}/alb_public_sg_id"
}

data "aws_ssm_parameter" "alb_private_sg_id" {
  name = "/${var.project_name}/${var.environment}/alb_private_sg_id"
}

data "aws_ssm_parameter" "public_subent" {
  name = "/${var.project_name}/${var.environment}/vpc-1/public-subnet_id"
}

data "aws_ssm_parameter" "private_subent" {
  name = "/${var.project_name}/${var.environment}/vpc-2/private-subnet_id"
}
