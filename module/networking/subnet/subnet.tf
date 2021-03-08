module "vpc" {
    source = "../vpc"
}

resource "aws_subnet" "public_subnet" {
    availability_zone = var.public_subnet_az
    cidr_block = var.public_subnet_cidr_block
    vpc_id = module.vpc.vpc_id
    map_public_ip_on_launch = true
    assign_ipv6_address_on_creation = false

    tags = {
        "Name" = "${var.environment}-public"
        "Environment" = var.environment
        "Subnet Type" = "Public"
    }
}

resource "aws_subnet" "private_subnet" {
    availability_zone = var.private_subnet_az
    cidr_block = var.private_subnet_cidr_block
    vpc_id = module.vpc.vpc_id
    map_public_ip_on_launch = false
    assign_ipv6_address_on_creation = false

    tags = {
        "Name" = "${var.environment}-private"
        "Environment" = var.environment
        "Subnet Type" = "Private"
    }
}