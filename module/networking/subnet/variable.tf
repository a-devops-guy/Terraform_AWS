variable "vpc_id" {
    type = string
}

variable "subnets" {
    type = list(object({
    subnet_az = string
    subnet_cidr_block = string
    public = bool
  }))
}

variable "environment" {
    type = string
}