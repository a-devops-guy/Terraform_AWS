resource "aws_route_table_association" "route_table" {
  count = length(var.subnet_ids) #data.aws_subnet_ids.private.ids
  subnet_id = element(tolist(var.subnet_ids),count.index)

  route_table_id = var.route_table_id #aws_route_table.public_route_table.id
}