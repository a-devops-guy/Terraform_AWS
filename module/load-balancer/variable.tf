variable "is_internal" {
  type = bool
  default = true
}

variable "name" {
  type = string
}

variable "environment" {
  type = string
}

variable "alb_sg" {
  type = list(string)
}

variable "alb_subnets" {
  type = list(string)
}

variable "target_group_port" {
  type = number
}

variable "target_group_protocol" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "protocol_version" {
  type = string
}

variable "bucket_name" {
  type = string
}