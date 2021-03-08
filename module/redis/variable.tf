variable "redis_az" {
  type = set(string)
  default = ["us-east-1a","us-east-1b"]
}

variable "name" {
  type = string
}

variable "parameter_group_name" {
  type = string
  default = "default.redis6.x"
}

variable "sg_names" {
  type = list(string)
}

variable "subnet_group_ids" {
  type = list(string)
}

variable "environment" {
  type = string
}