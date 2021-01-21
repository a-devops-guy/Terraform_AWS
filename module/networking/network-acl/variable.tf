variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "ingress_rules" {
    type = list(object({
    rule_no = number
    cidr = string
    protocol = string
    action = string
    from_port = number
    to_port = number
  }))
}

variable "egress_rules" {
    type = list(object({
    rule_no = number
    cidr = string
    protocol = string
    action = string
    from_port = number
    to_port = number
  }))
}


variable "environment" {
  type = string
}

variable "name" {
  type = string
}