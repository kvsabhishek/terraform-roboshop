resource "aws_security_group" "all_ports_vpc2" {
  name   = "allow all_vpc2"
  vpc_id = aws_vpc.vpc2.id

  ingress {
    description = "allowing all ports"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc1_cidr}"]
  }

  egress {
    description = "allow all out traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "all_ports_vpc1" {
  name   = "allow all_vpc1"
  vpc_id = aws_vpc.vpc1.id

  ingress {
    description = "allowing all ports"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "allow all out traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
