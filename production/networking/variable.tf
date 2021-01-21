variable "region" {}
variable "access_key" { sensitive = true }
variable "secret_key" { sensitive = true }

variable "environment" {
  type = string
}