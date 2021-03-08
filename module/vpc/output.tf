output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "gw_id" {
    value = aws_internet_gateway.gw.id
}

output "default_nacl_id" {
    value = aws_vpc.vpc.default_network_acl_id
}

output "vpc_cidr_block" {
    value = aws_vpc.vpc.cidr_block
}