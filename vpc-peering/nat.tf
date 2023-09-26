resource "aws_eip" "vpc2_eip" {

}

resource "aws_nat_gateway" "vpc2" {
  allocation_id = aws_eip.vpc2_eip.id
  subnet_id     = aws_subnet.vpc2_private.id

  tags = merge(
    var.common_tags,
    {
      Name = "VPC2|NAT"
    }
  )
}
