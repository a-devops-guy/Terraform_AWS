module "subnet_az1_public" {
  source = "../../module/networking/subnet"
  
  #tagging
  environment = "Production"
  
  #subnet.tf
  public_subnet_az = "us-east-1a"
  public_subnet_cidr_block = "192.168.1.0/24"
}

module "subnet_az2_public" {
  source = "../../module/networking/subnet"
  
  #tagging
  environment = "Production"
  
  #subnet.tf
  public_subnet_az = "us-east-1b"
  public_subnet_cidr_block = "192.168.2.0/24"
}

module "subnet_az1_private" {
  source = "../../module/networking/subnet"

  #tagging
  environment = "Production"
  
  #subnet.tf
  private_subnet_az = "us-east-1a"
  private_subnet_cidr_block = "192.168.3.0/24"
}

module "subnet_az2_private" {
  source = "../../module/networking/subnet"

  #tagging
  environment = "Production"
  
  #subnet.tf
  private_subnet_az = "us-east-1b"
  private_subnet_cidr_block = "192.168.4.0/24"
}