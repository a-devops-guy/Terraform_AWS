resource "aws_default_route_table" "main_route_table" {
    default_route_table_id = var.default_route_table_id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = var.gw_id
    }

    tags = {
        Name = "${var.name}-Public-RT"
        Main = true
        Public = true
        Environment = var.environment
    }
}