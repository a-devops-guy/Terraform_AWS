resource "aws_default_network_acl" "default_nacl" {
  default_network_acl_id = module.vpc.default_nacl_id
  depends_on = [
      module.vpc,
  ]

  tags = {
    "Name" = "${var.environment}-default-nacl"
    "Environment" = var.environment
    "Public" = false
  }
}

#https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-security-groups.html#elb-vpc-nacl

resource "aws_network_acl" "varnish" { 
  vpc_id = module.vpc.vpc_id
  depends_on = [
      module.vpc,
  ]
  subnet_ids = data.aws_subnet_ids.varnish_subnet_ids.ids

  #varnish port
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }
  
    
  #ephermal port
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 1024
    to_port    = 65535
  }

  #ssh port
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 22
    to_port    = 22
  }

  #API
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 8080
    to_port    = 8080
  }

  #SF
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 3000
    to_port    = 3000
  }

  tags = {
    Name = "Varnish-NACL"
    Environment = var.environment
  }
}

resource "aws_network_acl" "SF" {
  vpc_id = module.vpc.vpc_id
  depends_on = [
      module.vpc,
  ]
  subnet_ids = data.aws_subnet_ids.sf_subnet_ids.ids

  #SF
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 3000
    to_port    = 3000
  }

  #ephermal port
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 1024
    to_port    = 65535
  }

  #ssh port
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 22
    to_port    = 22
  }

  #Redis
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 6379
    to_port    = 6379
  }

  tags = {
    Name = "SF-NACL"
    Environment = var.environment
  }
}

resource "aws_network_acl" "API" {
  vpc_id = module.vpc.vpc_id
  depends_on = [
      module.vpc,
  ]
  subnet_ids = data.aws_subnet_ids.api_subnet_ids.ids

  #API
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 8080
    to_port    = 8080
  }

  #ephermal port
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 1024
    to_port    = 65535
  }

  #ssh port
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 22
    to_port    = 22
  }
  
  #BO
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 80
    to_port    = 80
  }

  #Elasticsearch
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 443
    to_port    = 443
  }

  tags = {
    Name = "API-NACL"
    Environment = var.environment
  }
}

resource "aws_network_acl" "BO" {
  vpc_id = module.vpc.vpc_id
  depends_on = [
      module.vpc,
  ]
  subnet_ids = data.aws_subnet_ids.bo_subnet_ids.ids

  #BO
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  #ephermal port
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 1024
    to_port    = 65535
  }

  #ssh port
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 22
    to_port    = 22
  }
  
  #MySQL
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 3306
    to_port    = 3306
  }

  #EFS  
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 2049
    to_port    = 2049
  }

  #Elasticsearch
  egress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 443
    to_port    = 443
  }

  tags = {
    Name = "BO-NACL"
    Environment = var.environment
  }
}

resource "aws_network_acl" "PaaS" {
  vpc_id = module.vpc.vpc_id
  depends_on = [
      module.vpc,
  ]
  subnet_ids = data.aws_subnet_ids.paas_subnet_ids.ids

  #Redis
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 6379
    to_port    = 6379
  }

  #MQ
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 5672
    to_port    = 5672
  }

  #MySQL
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 3306
    to_port    = 3306
  }

  #Elasticsearch
  ingress {
    protocol   = "tcp"
    rule_no    = 400
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 443
    to_port    = 443
  }

  #ephermal port
  ingress {
    protocol   = "tcp"
    rule_no    = 500
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 1024
    to_port    = 65535
  }

#need to modify egress port based on cron job if required

  tags = {
    Name = "PaaS-NACL"
    Environment = var.environment
  }
}

resource "aws_network_acl" "public" {
  vpc_id = module.vpc.vpc_id
  depends_on = [
      module.vpc,
  ]
  subnet_ids = data.aws_subnet_ids.public_subnet_ids.ids

  #ssh port
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }
  
  #ephermal port
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 1
    to_port    = 65535
  }

  #API
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = module.vpc.vpc_cidr_block
    from_port  = 1
    to_port    = 65535
  }

  tags = {
    Name = "public-NACL"
    Environment = var.environment
  }
}

resource "aws_network_acl" "cron" {
  vpc_id = module.vpc.vpc_id
  depends_on = [
      module.vpc,
  ]
  subnet_ids = data.aws_subnet_ids.cron_subnet_ids.ids

  tags = {
    Name = "cron-NACL"
    Environment = var.environment
  }
}