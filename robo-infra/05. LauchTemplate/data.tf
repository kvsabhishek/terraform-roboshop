data "aws_ami" "devops_ami" {
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
  owners      = ["973714476881"]

  filter {
    name   = "name"
    values = ["Centos-8-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ssm_parameter" "sg" {
  for_each = toset(concat(["vpc1", "vpc2", "web", "alb_public", "alb_private"], local.components))

  name = "/${var.project_name}/${var.environment}/${each.value}_sg_id"
}

