resource "aws_security_group" "vpc1" {
  name   = "allow ssh to vpn"
  vpc_id = data.aws_ssm_parameter.vpc1_id.value
  tags = merge(
    var.common_tags,
    {
      Name = "VPN"
    }
  )

  ingress {
    description = "Allowing SSH to connect to Hosts"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allowing all output"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "vpc2" {
  name   = "allow connection from vpn"
  vpc_id = data.aws_ssm_parameter.vpc2_id.value

  tags = merge(
    var.common_tags,
    {
      Name = "VPN-VPC"
    }
  )

  ingress {
    description     = "Allowing SSH to connect to Hosts"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.vpc1.id]
  }

  egress {
    description = "Allowing all output"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "component" {
  for_each = toset(concat(["web"], local.components))
  name     = "security group for ${each.value}"
  vpc_id   = data.aws_ssm_parameter.vpc2_id.value

  egress {
    description = "Allowing all output"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "alb_public" {
  name   = "allowing internet traffic to alb public"
  vpc_id = data.aws_ssm_parameter.vpc2_id.value
}

resource "aws_security_group" "alb_private" {
  name   = "allowing web traffic to alb private"
  vpc_id = data.aws_ssm_parameter.vpc2_id.value
}

resource "aws_security_group_rule" "alb_public" {

  security_group_id = aws_security_group.alb_public.id

  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "https"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_private" {

  security_group_id = aws_security_group.alb_private.id

  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "http"
  source_security_group_id = aws_security_group.component["web"].id
}

resource "aws_security_group_rule" "web" {

  security_group_id = aws_security_group.component["web"].id

  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "https"
  source_security_group_id = aws_security_group.alb_public.id
}

resource "aws_security_group_rule" "api_components" {

  for_each = toset(var.api_tier_components)

  security_group_id = aws_security_group.component[each.value].id

  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "http"
  source_security_group_id = aws_security_group.alb_private.id
}

resource "aws_security_group_rule" "user_mongo" {
  security_group_id = aws_security_group.component["mongodb"].id

  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.component["user"].id
}

resource "aws_security_group_rule" "catalouge_mongo" {
  security_group_id = aws_security_group.component["mongodb"].id

  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.component["catalouge"].id
}

resource "aws_security_group_rule" "cart_redis" {
  security_group_id = aws_security_group.component["redis"].id

  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.component["cart"].id
}

resource "aws_security_group_rule" "user_redis" {
  security_group_id = aws_security_group.component["redis"].id

  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.component["user"].id
}

resource "aws_security_group_rule" "shipping_mysql" {
  security_group_id = aws_security_group.component["mysql"].id

  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.component["shipping"].id
}

resource "aws_security_group_rule" "rating_mysql" {
  security_group_id = aws_security_group.component["mysql"].id

  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.component["rating"].id
}

resource "aws_security_group_rule" "payment_rabbit" {
  security_group_id = aws_security_group.component["rabbitmq"].id

  type                     = "ingress"
  from_port                = 5672
  to_port                  = 5672
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.component["payment"].id
}
