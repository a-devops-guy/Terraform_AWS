resource "aws_default_network_acl" "default_nacl" {
  #./vpc.tf
  default_network_acl_id = module.vpc.vpc_default_nacl

  tags = {
    "Name" = "${var.environment}-default-nacl"
    "Environment" = var.environment
    "Public" = false
  }
}

module "nginx_nacl" {
  source = "../../module/networking/network-acl"
  
  #tagging
  name = "Nginx-Varnish"
  environment = var.environment

  #./vpc.tf
  vpc_id = module.vpc.vpc_id

  #./subnet.tf 
  subnet_ids = sort(data.aws_subnet_ids.public.ids)
  
  ingress_rules = [
    {
      protocol = "tcp"
      rule_no = 100
      action = "allow"
      cidr = "0.0.0.0/0"
      from_port = 443
      to_port = 443
    }
  ]

  egress_rules = [
    {
      protocol = "tcp"
      rule_no = 100
      action = "allow"
      cidr = "0.0.0.0/0"
      from_port = 1024
      to_port = 65535 #ephermal ports
    }
  ]
}

module "application_nacl" {
  source = "../../module/networking/network-acl"
  
  #tagging
  name = "application"
  environment = var.environment

  #./vpc.tf
  vpc_id = module.vpc.vpc_id

  #./subnet.tf 
  subnet_ids = sort(data.aws_subnet_ids.application.ids)
  
  ingress_rules = [
    {
      protocol = "tcp"
      rule_no = 100
      action = "allow"
      cidr = "192.168.1.0/24" #nginx subnet 1
      from_port = 443
      to_port = 443 #BO
    },
    {
      protocol = "tcp"
      rule_no = 200
      action = "allow"
      cidr = "192.168.1.0/24"
      from_port = 3000 #storefront
      to_port = 3000
    },
    {
      protocol = "tcp"
      rule_no = 300
      action = "allow"
      cidr = "192.168.1.0/24"
      from_port = 8080
      to_port = 8080 #api
    },
    {
      protocol = "tcp"
      rule_no = 110
      action = "allow"
      cidr = "192.168.2.0/24" #nginx subnet 1
      from_port = 443
      to_port = 443 #BO
    },
    {
      protocol = "tcp"
      rule_no = 210
      action = "allow"
      cidr = "192.168.2.0/24"
      from_port = 3000 #storefront
      to_port = 3000
    },
    {
      protocol = "tcp"
      rule_no = 310
      action = "allow"
      cidr = "192.168.2.0/24"
      from_port = 8080
      to_port = 8080 #api
    }
  ]

  egress_rules = [
    {
      protocol = "tcp"
      rule_no = 100
      action = "allow"
      cidr = "192.168.1.0/24" #nginx subnet 1
      from_port = 1024
      to_port = 65535 #ephermal ports
    },
    {
      protocol = "tcp"
      rule_no = 200
      action = "allow"
      cidr = "192.168.2.0/24" #nginx subnet 1
      from_port = 1024
      to_port = 65535 #ephermal ports
    },
    {
      protocol = "tcp"
      rule_no = 300
      action = "allow"
      cidr = "192.168.5.0/24" #nginx subnet 1
      from_port = 1024
      to_port = 65535 #ephermal ports
    },
    {
      protocol = "tcp"
      rule_no = 400
      action = "allow"
      cidr = "192.168.6.0/24" #nginx subnet 1
      from_port = 1024
      to_port = 65535 #ephermal ports
    }
  ]
}

module "PaaS_nacl" {
  source = "../../module/networking/network-acl"
  
  #tagging
  name = "PaaS"
  environment = var.environment

  #./vpc.tf
  vpc_id = module.vpc.vpc_id

  #./subnet.tf 
  subnet_ids = sort(data.aws_subnet_ids.PaaS.ids)
  
  ingress_rules = [
    {
      protocol = "tcp"
      rule_no = 100
      action = "allow"
      cidr = "192.168.3.0/24" #nginx subnet 1
      from_port = 443
      to_port = 443 #ES
    },
    {
      protocol = "tcp"
      rule_no = 200
      action = "allow"
      cidr = "192.168.3.0/24"
      from_port = 3306 #mysql
      to_port = 3306
    },
    {
      protocol = "tcp"
      rule_no = 300
      action = "allow"
      cidr = "192.168.3.0/24"
      from_port = 6379 
      to_port = 6379 #redis
    },
    {
      protocol = "tcp"
      rule_no = 110
      action = "allow"
      cidr = "192.168.4.0/24" #nginx subnet 1
      from_port = 443
      to_port = 443 #ES
    },
    {
      protocol = "tcp"
      rule_no = 210
      action = "allow"
      cidr = "192.168.4.0/24"
      from_port = 3306 #mysql
      to_port = 3306
    },
    {
      protocol = "tcp"
      rule_no = 310
      action = "allow"
      cidr = "192.168.4.0/24"
      from_port = 6379
      to_port = 6379 #redis
    }
  ]

  egress_rules = [
    {
      protocol = "tcp"
      rule_no = 100
      action = "allow"
      cidr = "192.168.3.0/24" #nginx subnet 1
      from_port = 1024
      to_port = 65535 #ephermal ports
    },
    {
      protocol = "tcp"
      rule_no = 200
      action = "allow"
      cidr = "192.168.4.0/24" #nginx subnet 1
      from_port = 1024
      to_port = 65535 #ephermal ports
    }
  ]
}