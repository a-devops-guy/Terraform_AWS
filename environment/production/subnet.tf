module "subnet" {
  source = "../../module/subnet"
  depends_on = [
      module.vpc,
  ]

  environment = var.environment
  vpc_id = module.vpc.vpc_id
  
  subnets = [
    {   #Varnish AZ-1
        name = "Varnish-Server"
        subnet_az = "us-east-1a",
        subnet_cidr_block = "192.168.1.0/24"
        public = false
    },
    {   #Varnish AZ-2
        name = "Varnish-Server"
        subnet_az = "us-east-1b",
        subnet_cidr_block = "192.168.2.0/24"
        public = false
    },
    {   #SF-ASG AZ-1
        name = "SF-Servers"
        subnet_az = "us-east-1a",
        subnet_cidr_block = "192.168.3.0/24"
        public = false
    },
    {   #SF-ASG AZ-2
        name = "SF-Servers"
        subnet_az = "us-east-1b",
        subnet_cidr_block = "192.168.4.0/24"
        public = false
    },
    {   #API-ASG AZ-1
        name = "API-Servers"
        subnet_az = "us-east-1a",
        subnet_cidr_block = "192.168.5.0/24"
        public = false
    },
    {   #API-ASG AZ-2
        name = "API-Servers"
        subnet_az = "us-east-1b",
        subnet_cidr_block = "192.168.6.0/24"
        public = false
    },
    {   #BO AZ-1
        name = "BO-Servers"
        subnet_az = "us-east-1a",
        subnet_cidr_block = "192.168.7.0/24"
        public = false
    },
    {   #BO AZ-2
        name = "BO-Servers"
        subnet_az = "us-east-1b",
        subnet_cidr_block = "192.168.8.0/24"
        public = false
    },
    {   #PaaS Services AZ-1
        name = "PaaS-Services"
        subnet_az = "us-east-1a",
        subnet_cidr_block = "192.168.9.0/24"
        public = false
    },
    {   #PaaS Services AZ-2
        name = "PaaS-Services"
        subnet_az = "us-east-1b",
        subnet_cidr_block = "192.168.10.0/24"
        public = false
    },
    {   #cron AZ-1
        name = "Cron-server"
        subnet_az = "us-east-1a",
        subnet_cidr_block = "192.168.11.0/24"
        public = false
    },
    {   #cron AZ-2
        name = "Cron-server"
        subnet_az = "us-east-1b",
        subnet_cidr_block = "192.168.12.0/24"
        public = false
    },
    {   #Public AZ-1 - for jumphost, jenkins etc
        name = "Public"
        subnet_az = "us-east-1a",
        subnet_cidr_block = "192.168.13.0/24"
        public = true
    }
]
}
