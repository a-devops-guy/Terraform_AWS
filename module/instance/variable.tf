variable "ami_id" {
    type = string

    #https://www.terraform.io/docs/language/values/variables.html#custom-validation-rules   
    validation {
        condition     = length(var.ami_id) > 4 && substr(var.ami_id, 0, 4) == "ami-"
        error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "iam_instance_profile" {
    type =  string
}

variable "placement_group" {
    type = string
}

variable "ec2_security_groups" {
    type = list(string)
}

variable "ec2_subnet_id" {
    type = string
}

variable "user_data" {
    type = string
}

variable "environment" {
    type = string
}

variable "target_group_arn" {
    type = string
}

variable "target_group_port" {
    type = string
}

variable "name" {
    type = string
}