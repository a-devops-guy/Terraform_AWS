resource "aws_route_table" "route_table_private" {
    vpc_id = var.vpc_id

    tags = {
        Name = "${var.name}-private-RT"
        Main = false
        Public = false
        Environment = var.environment
    }
}