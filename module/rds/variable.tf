

variable "rds_name" {
  type = string
}

variable "db_name" {
  type = string
}

variable "option_group_name" {
  type = string
}

variable "parameter_group_name" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "password" {
  type = string
}