resource "aws_lb" "lb" {
  for_each           = toset(var.lb)
  name               = each.value
  internal           = each.value == "private" ? true : false
  load_balancer_type = "application"
  security_groups    = ["data.aws_ssm_parameter.alb_${each.value}_sg_id"]
  subnets            = each.value == "private" ? ["${data.aws_ssm_parameter.private_subent}"] : ["${data.aws_ssm_parameter.public_subent}"]

  tags = merge(
    var.common_tags,
    {
      Name = "${each.key}"
    }
  )
}

resource "aws_lb_target_group" "target" {
  for_each = toset(concat(["web"], local.components))

  name     = each.value
  protocol = 8080
}
