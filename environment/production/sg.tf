resource "aws_default_security_group" "default" {
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group" "varnish" {
  vpc_id = module.vpc.vpc_id
  depends_on = [
      module.vpc,
  ]

  #varnish port
  ingress {
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 80
    to_port    = 80
  }
  
  #ephermal port
  ingress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 1024
    to_port    = 65535
  }

  #API
  egress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 8080
    to_port    = 8080
  }

  #SF
  egress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 3000
    to_port    = 3000
  }

  #ssh port
  ingress {
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 22
    to_port    = 22
  }

  tags = {
    Name = "Varnish-SG"
    Environment = var.environment
  }
}

resource "aws_security_group" "SF" {
  vpc_id = module.vpc.vpc_id
  depends_on = [
      module.vpc,
  ]

  #SF
  ingress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 3000
    to_port    = 3000
  }

  #ephermal port
  ingress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 1024
    to_port    = 65535
  }

  #Redis
  egress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 6379
    to_port    = 6379
  }

  #ssh port
  ingress {
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 22
    to_port    = 22
  }

  tags = {
    Name = "SF-SG"
    Environment = var.environment
  }
}

resource "aws_security_group" "API" {
  vpc_id = module.vpc.vpc_id
  depends_on = [
      module.vpc,
  ]

  #API
  ingress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 8080
    to_port    = 8080
  }

  #ephermal port
  ingress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 1024
    to_port    = 65535
  }
  
  #BO
  egress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 80
    to_port    = 80
  }

  #Elasticsearch
  egress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 443
    to_port    = 443
  }

  #ssh port
  ingress {
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 22
    to_port    = 22
  }

  tags = {
    Name = "API-SG"
    Environment = var.environment
  }
}

resource "aws_security_group" "BO" {
  vpc_id = module.vpc.vpc_id
  depends_on = [
      module.vpc,
  ]

  #BO
  ingress {
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 80
    to_port    = 80
  }

  #ephermal port
  ingress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 1024
    to_port    = 65535
  }
  
  #MySQL
  egress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 3306
    to_port    = 3306
  }

  #EFS  
  egress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 2049
    to_port    = 2049
  }

  #Elasticsearch
  egress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 443
    to_port    = 443
  }

  #ssh port
  ingress {
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 22
    to_port    = 22
  }

  tags = {
    Name = "BO-SG"
    Environment = var.environment
  }
}

resource "aws_security_group" "PaaS" {
  vpc_id = module.vpc.vpc_id
  depends_on = [
      module.vpc,
  ]

  #Redis
  ingress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 6379
    to_port    = 6379
  }

  #MQ
  ingress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 5672
    to_port    = 5672
  }

  #MySQL
  ingress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 3306
    to_port    = 3306
  }

  #Elasticsearch
  ingress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 443
    to_port    = 443
  }

  #ephermal port
  ingress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 1024
    to_port    = 65535
  }

#need to modify egress port based on cron job if required

  tags = {
    Name = "PaaS-SG"
    Environment = var.environment
  }
}

resource "aws_security_group" "public" {
  vpc_id = module.vpc.vpc_id
  depends_on = [
      module.vpc,
  ]

  #ssh port
  ingress {
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 22
    to_port    = 22
  }
  
  #ephermal port
  ingress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 1024
    to_port    = 65535
  }

  #ssh
  egress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 22
    to_port    = 22
  }

  tags = {
    Name = "public-SG"
    Environment = var.environment
  }
}

resource "aws_security_group" "cron" {
  vpc_id = module.vpc.vpc_id
  depends_on = [
      module.vpc,
  ]

  tags = {
    Name = "cron-SG"
    Environment = var.environment
  }
}

resource "aws_security_group" "efs" {
  vpc_id = module.vpc.vpc_id
  depends_on = [
      module.vpc,
  ]

  ingress {
    protocol   = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    from_port  = 2049
    to_port    = 2049
  }

  tags = {
    Name = "efs-SG"
    Environment = var.environment
  }
}