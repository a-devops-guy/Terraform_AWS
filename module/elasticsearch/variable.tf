variable "domain_name" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "instance_count" {
  type = number
  default = 3
}

variable "instance_type" {
  type = string
  default = "c5.large.elasticsearch"
}