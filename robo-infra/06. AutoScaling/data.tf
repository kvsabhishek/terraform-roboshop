data "aws_ssm_parameter" "template_name" {
  for_each = toset(concat(["web"], local.components))

  name = "/${var.project_name}/${var.environment}/${each.value}_template_name"
}

data "aws_ssm_parameter" "template_id" {
  for_each = toset(concat(["web"], local.components))

  name = "/${var.project_name}/${var.environment}/${each.value}_template_id"
}

data "aws_ssm_parameter" "public_subent" {
  name = "/${var.project_name}/${var.environment}/vpc-1/public-subnet_id"
}

data "aws_ssm_parameter" "private_subent" {
  name = "/${var.project_name}/${var.environment}/vpc-2/private-subnet_id"
}

data "aws_ssm_parameter" "database_subent" {
  name = "/${var.project_name}/${var.environment}/vpc-2/database-subnet_id"
}
