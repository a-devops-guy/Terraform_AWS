data "aws_subnet_ids" "private" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Environment = var.environment
    "Public" = false
  }

  # filter {
  #   name   = "tag:Public"
  #   values = ["true"]
  # }

  # filter {
  #   name = "tag:Environment"
  #   values = [var.environment]
  # }
}

data "aws_subnet_ids" "public" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Environment = var.environment
    "Public" = true
  }
}

data "aws_subnet_ids" "application" {
  vpc_id = module.vpc.vpc_id

  filter {
    name = "tag:Name"
    values = ["App-Servers-Prod-*"]
  }
}

data "aws_subnet_ids" "PaaS" {
  vpc_id = module.vpc.vpc_id

  filter {
    name = "tag:Name"
    values = ["PaaS-Prod-*"]
  }
}