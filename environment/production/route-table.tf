resource "aws_route_table" "public_route_table" {
  vpc_id = module.vpc.vpc_id
  depends_on = [
    module.subnet,
  ]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.vpc.gw_id
  }

  tags = {
        Name = "${var.environment}-public-RT"
        Main = false
        Public = true
        Environment = var.environment
    }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = module.vpc.vpc_id
  depends_on = [
    module.subnet,
  ]

  tags = {
        Name = "${var.environment}-private-RT"
        Main = false
        Public = true
        Environment = var.environment
    }
}

module "public_route_table" {
  source = "../../module/rt-association"
  depends_on = [
    module.subnet,
    aws_route_table.public_route_table,
  ]

  subnet_ids     = data.aws_subnet_ids.public_subnet_ids.ids
  route_table_id = aws_route_table.public_route_table.id
}

module "private_route_table" {
  source = "../../module/rt-association"
  depends_on = [
    module.subnet,
    aws_route_table.private_route_table,
  ]
  
  subnet_ids     = data.aws_subnet_ids.private_subnet_ids.ids
  route_table_id = aws_route_table.private_route_table.id
}