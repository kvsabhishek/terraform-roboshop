resource "aws_internet_gateway" "vpc1" {
  vpc_id = aws_vpc.vpc1.id
}

resource "aws_internet_gateway" "vpc2" {
  vpc_id = aws_vpc.vpc2.id
}
