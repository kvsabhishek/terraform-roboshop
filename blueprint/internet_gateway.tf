resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.roboshop_vpc.id

  tags = merge({ Name = "${var.project_name}-internet_gateway" }, var.common_tags)
}
