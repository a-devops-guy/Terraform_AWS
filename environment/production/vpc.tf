module "vpc" {
    source = "../../module/vpc"

    environment = var.environment
    vpc_cidr_block = "192.168.0.0/16"
    vpc_instance_tenancy = "default"
    dhcp_domain_name = "vue.test"
}