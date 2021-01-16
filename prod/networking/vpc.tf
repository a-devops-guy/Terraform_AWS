module "vpc" {
  source = "../../module/networking/vpc"
  
  #tagging
  environment = var.environment
  
  #dhcp.tf
  domain_name_servers =["8.8.8.8"]
  domain_name = "vue.prod"
  
  #vpc.tf
  vpc_cidr_block = "192.168.0.0/16"
}

#ig
#tagging 
#route table
#network nacl
#subnet