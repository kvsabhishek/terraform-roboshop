resource "aws_ssm_parameter" "vpn_sg" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/vpnsg_id"
  value = aws_security_group.vpc1.id
}

resource "aws_ssm_parameter" "vpc2_sg" {
  type  = "String"
  name  = "/${var.project_name}/${var.environment}/vpc2_id"
  value = aws_security_group.vpc2.id
}
