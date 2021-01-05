#Associate public subnet to main route
resource "aws_default_route_table" "main_route_table" {
    default_route_table_id = aws_vpc.prod_vpc.default_route_table_id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.prd_gw.id
    }

    tags = {
        Name = "Public RT"
        main = "Yes"
    }
}

#Associate private subnet to private route
resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.prod_vpc.id
    
    tags = {
        Name = "Private RT"
        main = "No"
    }
}

resource "aws_route_table_association" "private_az1_association" {
    subnet_id      = aws_subnet.private_az1.id
    route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_az2_association" {
    subnet_id      = aws_subnet.private_az2.id
    route_table_id = aws_route_table.private_route_table.id
}