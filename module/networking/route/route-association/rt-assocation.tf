resource "aws_route_table_association" "rt_association" {
    # for_each = [ for s in var.subnets_id : s ]

    subnet_id      = var.subnets_id
    route_table_id = var.route_table_id
}