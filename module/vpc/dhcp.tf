resource "aws_vpc_dhcp_options" "dhcp" {
    domain_name_servers = var.dhcp_domain_name_servers
    domain_name = var.dhcp_domain_name
    ntp_servers = var.dhcp_ntp_servers
    netbios_name_servers = var.dhcp_netbios_name_servers
    netbios_node_type = 2

    tags = {
        Name = "${var.environment}-dhcp"
        Environment = var.environment
    }
}

resource "aws_vpc_dhcp_options_association" "dhcp_association" {
    vpc_id          = aws_vpc.vpc.id
    dhcp_options_id = aws_vpc_dhcp_options.dhcp.id
}
