resource "aws_vpc_dhcp_options" "dhcp" {
    domain_name_servers = var.domain_name_servers
    domain_name = var.domain_name
    ntp_servers = var.ntp_servers

    tags = {
        Name = "${var.environment}-dhcp"
        Environment = var.environment
    }
}

resource "aws_vpc_dhcp_options_association" "dhcp_association" {
    vpc_id          = aws_vpc.vpc.id
    dhcp_options_id = aws_vpc_dhcp_options.dhcp.id
}
