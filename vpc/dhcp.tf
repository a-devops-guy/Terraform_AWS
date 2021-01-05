resource "aws_vpc_dhcp_options" "prod_dhcp" {
    domain_name_servers = ["8.8.8.8", "8.8.4.4"]
    domain_name = "vuesf.prod"
    ntp_servers = [ "132.163.96.1", "132.163.96.2", "132.163.96.3", "132.163.96.4" ]
}

resource "aws_vpc_dhcp_options_association" "prod_dhcp_association" {
    vpc_id          = aws_vpc.prod_vpc.id
    dhcp_options_id = aws_vpc_dhcp_options.prod_dhcp.id
}