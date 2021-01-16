module "subnet" {
  source = "../../module/networking/subnet"
  
  #tagging
  environment = var.environment

  #subnet.tf
  vpc_id = module.vpc.vpc_id
  subnets = [
    {
        subnet_az = "us-east-1a",
        subnet_cidr_block = "192.168.1.0/24"
        public = true
    },
    {
        subnet_az = "us-east-1b",
        subnet_cidr_block = "192.168.2.0/24"
        public = true
    },
    {
        subnet_az = "us-east-1a",
        subnet_cidr_block = "192.168.3.0/24"
        public = false
    },
    {
        subnet_az = "us-east-1b",
        subnet_cidr_block = "192.168.4.0/24"
        public = false
    }
]
}
