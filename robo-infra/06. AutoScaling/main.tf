resource "aws_autoscaling_group" "autoscale" {
  for_each                  = toset(concat(["web"], var.api_tier_components))
  name                      = each.value
  max_size                  = 5
  min_size                  = 1
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  launch_template {
    id      = data.aws_ssm_parameter.template_id["${each.value}"].value
    version = "$Latest"
  }

  vpc_zone_identifier = contains(var.api_tier_components, each.value) ? ["${data.aws_ssm_parameter.private_subent.value}"] : ["${data.aws_ssm_parameter.public_subent.value}"]

  #   launch_configuration = data.aws_ssm_parameter.template["${each.value}"].value

  tag {
    key                 = "Name"
    value               = each.value
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "policy" {
  for_each = aws_autoscaling_group.autoscale

  autoscaling_group_name = each.value.name
  name                   = each.key
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 80.0
  }
}

resource "aws_instance" "db" {
  for_each = var.db_tier_components
  launch_template {
    name    = data.aws_ssm_parameter.launch_template_name["${each.value}"].value
    id      = data.aws_ssm_parameter.launch_template_id["${each.value}"].value
    version = "$Latest"
  }
}
