resource "aws_route_table" "route_table_public" {
    vpc_id = var.vpc_id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = var.ig_id
    }

    tags = {
        Name = "${var.name}-public-RT"
        Main = false
        Public = true
        Environment = var.environment
    }
}