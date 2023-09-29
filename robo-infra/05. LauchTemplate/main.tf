resource "aws_launch_template" "template" {
  for_each = toset(concat(["web"], local.components))

  name          = each.value
  image_id      = data.aws_ami.devops_ami.id
  instance_type = each.value == "mysql" ? "t3.medium" : "t2.micro"

  instance_initiated_shutdown_behavior = "terminate"
  vpc_security_group_ids               = ["${data.aws_ssm_parameter.sg[each.value].value}", "${data.aws_ssm_parameter.sg["vpc2"].value}"]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = each.value
    }
  }

  # user_data = filebase64("${path.module}/${each.value}.sh")
}


