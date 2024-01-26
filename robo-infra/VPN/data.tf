data "aws_ssm_parameter" "vpc1_id" {
  name       = "vpc1_id"
  depends_on = [module.vpc_infra]
}

data "aws_ssm_parameter" "vpc2_id" {
  name       = "vpc2_id"
  depends_on = [module.vpc_infra]
}

# data "aws_ssm_parameter" "vpc1-public-us-east-1a-table" {
#   name = "vpc1-public-us-east-1a-table"
# }

# data "aws_ssm_parameter" "vpc1-public-us-east-1b-table" {
#   name = "vpc1-public-us-east-1b-table"
# }

# data "aws_ssm_parameter" "vpc2-public-us-east-1a-table" {
#   name = "vpc2-public-us-east-1a-table"
# }

# data "aws_ssm_parameter" "vpc2-public-us-east-1b-table" {
#   name = "vpc2-public-us-east-1b-table"
# }

# data "aws_ssm_parameter" "vpc2-private-us-east-1a-table" {
#   name = "vpc2-public-us-east-1a-table"
# }
