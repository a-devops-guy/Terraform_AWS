output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "dhcp_id" {
    value = aws_vpc_dhcp_options.dhcp.id
}