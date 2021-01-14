
resource "aws_subnet" "subnet" {
    for_each = { for subnet in var.subnets:
            subnet.subnet_cidr_block => subnet
    }

    availability_zone = each.value.subnet_az
    cidr_block = each.value.subnet_cidr_block
    vpc_id = var.vpc_id
    
    map_public_ip_on_launch = each.value.public
    assign_ipv6_address_on_creation = false

    tags = {
        "Name" = "${each.value.subnet_az}-${var.environment}"
        "Environment" = var.environment
        "Public" = each.value.public
    }
}