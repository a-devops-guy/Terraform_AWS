output "vpc_id" {
  value = module.vpc.vpc_id
}

output "dhcp_id" {
    value = module.vpc.dhcp_id
}

output "subnets" {
  value = module.subnet.subnet_id
}

output "environment" {
  value = module.vpc.environment
}

output "gw_id" {
  value = module.vpc.gw_id
}

output "vpc_default_rt" {
  value = module.vpc.vpc_default_rt
}

output "public_route_table_id" {
  value = module.rt_public.public_route_table_id
}

output "private_route_table_id" {
  value = module.rt_private.private_route_table_id
}

# output "public_subnet_cidr" {
#   value = [for s in data.aws_subnet.public_subnet: s.cidr_block]
# }