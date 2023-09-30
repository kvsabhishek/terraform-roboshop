resource "aws_autoscaling_group" "name" {
  for_each                  = toset(concat(["web"], local.components))
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

  vpc_zone_identifier = contains(var.api_tier_components, each.value) ? ["${data.aws_ssm_parameter.private_subent.value}"] : contains(var.db_tier_components, each.value) ? ["${data.aws_ssm_parameter.database_subent.value}"] : ["${data.aws_ssm_parameter.public_subent.value}"]

  #   launch_configuration = data.aws_ssm_parameter.template["${each.value}"].value

  tag {
    key                 = "Name"
    value               = each.value
    propagate_at_launch = true
  }
}
