resource "aws_route_table_association" "rt_association" {
    subnet_id      = var.subnets_id
    route_table_id = var.route_table_id
}