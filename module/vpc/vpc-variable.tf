variable "vpc_cidr_block" {
  type = string

  validation {
    condition     = can(regex("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]).){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])/([1][6-9]|2[0-8])$",var.vpc_cidr_block))
    error_message = "Make sure the cidr is of range 16 - 28."
  }
}

variable "vpc_instance_tenancy" {
  type = string
  default = "default"

  validation {
    condition     = can(regex("^(default|dedicated|host)",var.vpc_instance_tenancy))
    error_message = "Valid options are default, dedicated, host or remove this variable and the default is set to 'default' type."
  }
}