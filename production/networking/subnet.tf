module "subnet" {
  source = "../../module/networking/subnet"
  
  #tagging
  environment = var.environment

  #./vpc.tf
  vpc_id = module.vpc.vpc_id

  #subnet.tf
  subnets = [
    {   #Nginx AZ-1
        name = "Nginx-Varnish"
        subnet_az = "us-east-1a",
        subnet_cidr_block = "192.168.1.0/24"
        public = true
    },
    {   #Nginx AZ-2
        name = "Nginx-Varnish"
        subnet_az = "us-east-1b",
        subnet_cidr_block = "192.168.2.0/24"
        public = true
    },
    {   #SF,API,BO AZ-1
        name = "App-Servers"
        subnet_az = "us-east-1a",
        subnet_cidr_block = "192.168.3.0/24"
        public = false
    },
    {   #SF,API,BO AZ-2
        name = "App-Servers"
        subnet_az = "us-east-1b",
        subnet_cidr_block = "192.168.4.0/24"
        public = false
    },
    {   #MySQL,ES,Redis AZ-1
        name = "PaaS"
        subnet_az = "us-east-1a",
        subnet_cidr_block = "192.168.5.0/24"
        public = false
    },
    {   #MySQL,ES,Redis,cron AZ-2
        name = "PaaS"
        subnet_az = "us-east-1b",
        subnet_cidr_block = "192.168.6.0/24"
        public = false
    }
]
}
