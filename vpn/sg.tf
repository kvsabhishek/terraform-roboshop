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
}
