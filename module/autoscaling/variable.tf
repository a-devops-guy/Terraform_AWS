variable "name" {
  type = string
}

variable "iam_instance_profile_name" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "security_groups" {
  type = list(string)
}

variable "user_data" {
  type = string
}

variable "placement_group" {
  type = string
}

variable "environment" {
  type = string
}

variable "default_version" {
  type = number
}

variable "subnet_ids" {
  type = list(string)
}

variable "launch_template_id" {
  type = string
}

variable "target_group_arns" {
  type = set(string)
}