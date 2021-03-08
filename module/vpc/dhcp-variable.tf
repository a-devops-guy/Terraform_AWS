variable "dhcp_domain_name_servers" {
    type = list(string)
    default = ["AmazonProvidedDNS"]
}

variable "dhcp_domain_name" {
    type = string
    validation {
        condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9].[a-zA-Z]{2,}$",var.dhcp_domain_name))
        error_message = "Enter valid domain name. eg. test.com."
  }
}

variable "dhcp_ntp_servers" {
    type = list(string)
    default = ["169.254.169.123"]

    #^\[[\s\d".,]*\] - regex not working due to double qoutes inside the regex. terraform considering as end of regex expression
}

variable "dhcp_netbios_name_servers" {
    type = list(string)
    default = []
}