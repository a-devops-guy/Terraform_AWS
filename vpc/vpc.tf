#Prod VPC
resource "aws_vpc" "prod_vpc" {
    cidr_block = "192.168.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = false

    tags = {
      "Name" = "prod_vpc"
      "Environment" = "Production"
      "App" = "Vue"
    }
}