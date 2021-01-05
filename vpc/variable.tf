variable "AWS_REGION" {
    type = string
    default = "us-east-1"
}

variable "AWS_ACCESS_KEY_ID" {
    type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
    type = string
}

variable "SF_PORT" {
    type = number
}

variable "API_PORT" {
    type = number
}

variable "HTTPS" {
    type = number
}

variable "MYSQL_PORT" {
    type = number
}

variable "REDIS_PORT" {
    type = number
}

variable "RABBITMQ_PORT" {
    type = number
}