resource "aws_instance" "vpc1_public" {
  ami                    = "ami-03265a0778a880afb"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.vpc1_sg.id]
  subnet_id              = aws_subnet.vpc1_public.id
  tags = merge(var.common_tags,
    {
      Name = "VPC-1|Public"
  })
}

resource "aws_instance" "vpc2_public" {
  ami                    = "ami-03265a0778a880afb"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.vpc2_sg.id]
  subnet_id              = aws_subnet.vpc2_public.id
  tags = merge(var.common_tags,
    {
      Name = "VPC-2|Public"
  })
}

resource "aws_instance" "vpc2_private" {
  ami                    = "ami-03265a0778a880afb"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.vpc2_sg.id]
  subnet_id              = aws_subnet.vpc2_private.id
  tags = merge(var.common_tags,
    {
      Name = "VPC-2|Private"
  })
}
