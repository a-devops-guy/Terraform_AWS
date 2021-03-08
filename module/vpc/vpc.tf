resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true
    instance_tenancy = var.vpc_instance_tenancy
    assign_generated_ipv6_cidr_block = false
    tags = {
        Name = "${var.environment}-vpc"
        Environment = "${var.environment}"
    }
}