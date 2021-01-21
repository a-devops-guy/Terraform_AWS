output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "dhcp_id" {
    value = aws_vpc_dhcp_options.dhcp.id
}

output "vpc_default_rt" {
    value = aws_vpc.vpc.default_route_table_id
}

output "vpc_default_nacl" {
    value = aws_vpc.vpc.default_network_acl_id
}

output "environment" {
    value = var.environment
}

output "gw_id" {
    value = aws_internet_gateway.gw.id
}
