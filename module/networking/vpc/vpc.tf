resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block
    enable_dns_support = true
    enable_dns_hostnames = false

    tags = {
        Name = "${var.environment}-vpc"
        Environment = "${var.environment}"
    }
}