terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

#https://www.youtube.com/watch?v=tL58Qt-RGHY&list=PL8HowI-L-3_9bkocmR3JahQ4Y-Pbqs2Nt&index=13 - dynamic blocks
#https://www.youtube.com/watch?v=uPKwNPomeJo&list=PL8HowI-L-3_9bkocmR3JahQ4Y-Pbqs2Nt&index=15 - provisioner