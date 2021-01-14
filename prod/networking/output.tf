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