#public subnet - us-east-1a - nginx/varnish
resource "aws_subnet" "public_az1" {
    availability_zone = "us-east-1a"
    cidr_block = "192.168.1.0/24"
    vpc_id = aws_vpc.prod_vpc.id
    map_public_ip_on_launch = true
    assign_ipv6_address_on_creation = false

    tags = {
        "Name" = "prod_vpc_zone_1_public"
        "Environment" = "Production"
        "App" = "Vue"
        "Zone" = "Public"
    }
}

#private subnet - us-east-1a
resource "aws_subnet" "private_az1" {
    availability_zone = "us-east-1a"
    cidr_block = "192.168.3.0/24"
    vpc_id = aws_vpc.prod_vpc.id
    map_public_ip_on_launch = false
    assign_ipv6_address_on_creation = false

    tags = {
        "Name" = "prod_vpc_zone_1_private"
        "Environment" = "Production"
        "App" = "Vue"
        "Zone" = "private"
    }
}

#public subnet - us-east-1b - nginx/varnish
resource "aws_subnet" "public_az2" {
    availability_zone = "us-east-1b"
    cidr_block = "192.168.2.0/24"
    vpc_id = aws_vpc.prod_vpc.id
    map_public_ip_on_launch = true
    assign_ipv6_address_on_creation = false

    tags = {
        "Name" = "prod_vpc_zone_2_public"
        "Environment" = "Production"
        "App" = "Vue"
        "Zone" = "Public"
    }
}

#private subnet - us-east-1b
resource "aws_subnet" "private_az2" {
    availability_zone = "us-east-1b"
    cidr_block = "192.168.4.0/24"
    vpc_id = aws_vpc.prod_vpc.id
    map_public_ip_on_launch = false
    assign_ipv6_address_on_creation = false

    tags = {
        "Name" = "prod_vpc_zone_2_private"
        "Environment" = "Production"
        "App" = "Vue"
        "Zone" = "private"
    }
}