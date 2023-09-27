resource "aws_ssm_parameter" "vpc_cidrs" {
  for_each = var.vpc_cidrs
  type     = "String"
  name     = "/${var.project_name}/${var.environment}/${each.key}"
  value    = each.value
}

resource "aws_ssm_parameter" "internet_gateway" {
  for_each = aws_internet_gateway.vpc
  type     = "String"
  name     = "/${var.project_name}/${var.environment}/${each.key}/internet_gateway_id"
  value    = each.value.id
}

resource "aws_ssm_parameter" "vpc1_subnet_cidrs" {
  for_each = var.vpc1_subnet_cidrs
  type     = "String"
  name     = "/${var.project_name}/${var.environment}/${local.vpc_list[0]}/${each.key}-cidr"
  value    = each.value
}

resource "aws_ssm_parameter" "vpc2_subnet_cidrs" {
  for_each = var.vpc2_subnet_cidrs
  type     = "String"
  name     = "/${var.project_name}/${var.environment}/${local.vpc_list[1]}/${each.key}-cidr"
  value    = each.value
}

resource "aws_ssm_parameter" "vpc1_route_table" {
  for_each = aws_route_table.vpc1
  type     = "String"
  name     = "/${var.project_name}/${var.environment}/${local.vpc_list[0]}/${each.key}-route_table_id"
  value    = each.value.id
}

resource "aws_ssm_parameter" "vpc2_route_table" {
  for_each = aws_route_table.vpc2
  type     = "String"
  name     = "/${var.project_name}/${var.environment}/${local.vpc_list[1]}/${each.key}-route_table_id"
  value    = each.value.id
}

resource "aws_ssm_parameter" "vpc1_subent_ids" {
  for_each = aws_subnet.vpc1
  type     = "String"
  name     = "/${var.project_name}/${var.environment}/${local.vpc_list[0]}/${each.key}-subnet_id"
  value    = each.value.id
}

resource "aws_ssm_parameter" "vpc2_subent_ids" {
  for_each = aws_subnet.vpc2
  type     = "String"
  name     = "/${var.project_name}/${var.environment}/${local.vpc_list[1]}/${each.key}-subnet_id"
  value    = each.value.id
}
