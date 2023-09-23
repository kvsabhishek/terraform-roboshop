resource "aws_instance" "vpc1_public" {
  ami                    = "ami-03a6eaae9938c858c"
  key_name               = data.aws_key_pair.devops.key_name
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.all_ports_vpc1.id}"]
  subnet_id              = aws_subnet.vpc1_public.id
}

resource "aws_instance" "vpc2_public" {
  ami                    = "ami-03a6eaae9938c858c"
  key_name               = data.aws_key_pair.devops.key_name
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.all_ports_vpc2.id}"]
  subnet_id              = aws_subnet.vpc2_public.id
}

resource "aws_instance" "vpc2_private" {
  ami                    = "ami-03a6eaae9938c858c"
  key_name               = data.aws_key_pair.devops.key_name
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.all_ports_vpc2.id}"]
  subnet_id              = aws_subnet.vpc2_private.id
}

