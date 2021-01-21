variable "environment" {
    type = string
}

variable "domain_name_servers" {
    type = list
    default = [ "8.8.8.8" ]
}

variable "domain_name" {
    type = string
}

variable "ntp_servers" {
    type = list
    default = [ "132.163.96.1", "132.163.96.2", "132.163.96.3", "132.163.96.4" ]
}

variable "vpc_cidr_block" {
    type = string
}