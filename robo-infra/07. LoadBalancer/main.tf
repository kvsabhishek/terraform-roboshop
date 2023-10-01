resource "aws_lb" "lb" {
  for_each           = var.lb
  name               = each.key
  internal           = each.value == "private" ? true : false
  load_balancer_type = "application"
  security_groups    = each.value == "private" ? ["${data.aws_ssm_parameter.alb_private_sg_id.value}"] : ["${data.aws_ssm_parameter.alb_public_sg_id.value}"]
  subnets            = each.value == "private" ? ["${data.aws_ssm_parameter.private_subent.value}"] : ["${data.aws_ssm_parameter.public_subent.value}"]

  tags = merge(
    var.common_tags,
    {
      Name = "${each.key}"
    }
  )
}

resource "aws_lb_target_group" "target" {
  for_each = toset(concat(["web"], var.api_tier_components))

  name     = each.value
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.aws_ssm_parameter.vpc2_id.value
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 5
    matcher             = "200-299"
    path                = "/health"
    port                = 8080
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 3
  }
}

resource "aws_autoscaling_attachment" "attach" {
  for_each = aws_lb_target_group.target

  autoscaling_group_name = each.key
  lb_target_group_arn    = each.value.arn

}


#<-------------------------CREATING SSL CERTIFICATION FOR HTTPS REQUEST----------------------->

resource "aws_acm_certificate" "devopsground" {
  domain_name       = "devopsground.online"
  validation_method = "DNS"
  tags              = var.common_tags
}

resource "aws_route53_record" "devopsground" {
  for_each = {
    for dvo in aws_acm_certificate.devopsground.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.devopsground.zone_id
}

resource "aws_acm_certificate_validation" "devopsground" {
  certificate_arn         = aws_acm_certificate.devopsground.arn
  validation_record_fqdns = [for record in aws_route53_record.devopsground : record.fqdn]
}

#<------------------------------------------------------------------------------------------->


resource "aws_lb_listener" "public_listener" {
  load_balancer_arn = aws_lb.lb["PublicALB"].arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.devopsground.arn

  default_action {

    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "This is the fixed response from Public load balancer"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener" "private_listener" {
  load_balancer_arn = aws_lb.lb["PrivateALB"].arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {

    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "This is the fixed response from private load balancer"
      status_code  = "200"
    }
  }
}
