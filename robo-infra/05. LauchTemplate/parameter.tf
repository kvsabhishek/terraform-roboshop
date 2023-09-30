resource "aws_ssm_parameter" "launch_template_name" {
  for_each = toset(concat(["web"], local.components))
  type     = "String"
  name     = "/${var.project_name}/${var.environment}/${each.value}_template_name"
  value    = aws_launch_template.template["${each.value}"].name
}

resource "aws_ssm_parameter" "launch_template_id" {
  for_each = toset(concat(["web"], local.components))
  type     = "String"
  name     = "/${var.project_name}/${var.environment}/${each.value}_template_id"
  value    = aws_launch_template.template["${each.value}"].id
}
