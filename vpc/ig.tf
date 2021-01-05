resource "aws_internet_gateway" "prd_gw" {
  vpc_id = aws_vpc.prod_vpc.id

  tags = {
    Name = "prod_gw"
  }
}