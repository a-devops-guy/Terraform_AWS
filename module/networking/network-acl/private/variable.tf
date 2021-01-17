variable "default_network_acl_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "private_nacl_rules" {
    type = list(object({
    rule_num = number
    cidr = list(string)
    protocol = string
    action = string
    port = number
  }))
}

variable "environment" {
  type = string
}