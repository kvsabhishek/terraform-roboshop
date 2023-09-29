resource "aws_ssm_parameter" "vpn_sg_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/vpn_sg_id"
  value = aws_security_group.vpc1.id
}

resource "aws_ssm_parameter" "vpc2_sg_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/vpc2_sg_id"
  value = aws_security_group.vpc2.id
}

resource "aws_ssm_parameter" "alb_public_sg_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/alb_public_sg_id"
  value = aws_security_group.alb_public.id
}

resource "aws_ssm_parameter" "alb_private_sg_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/alb_private_sg_id"
  value = aws_security_group.alb_private.id
}

resource "aws_ssm_parameter" "api_component_sg_id" {
  for_each = toset(concat(["web"], local.components))

  type  = "String"
  name  = "/${var.project_name}/${var.environment}/${each.value}_sg_id"
  value = aws_security_group.component["${each.value}"].id
}
