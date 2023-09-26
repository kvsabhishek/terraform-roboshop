resource "aws_security_group" "vpc1_sg" {
  name        = "Open"
  description = "allowing all traffic"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    description = "Allowing all traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allowing all traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "VPC-1|Open"
    }
  )
}

resource "aws_security_group" "vpc2_sg" {
  name        = "Open"
  description = "allowing all traffic"
  vpc_id      = aws_vpc.vpc2.id

  tags = merge(
    var.common_tags,
    {
      Name = "VPC-2|Open"
    }
  )
}

resource "aws_security_group_rule" "vpc2_sg_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.vpc1_sg.id
  security_group_id        = aws_security_group.vpc2_sg.id
}

resource "aws_security_group_rule" "vpc2_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vpc2_sg.id
}
