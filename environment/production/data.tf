data "aws_subnet_ids" "private_subnet_ids" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Environment = var.environment
    "Public" = false
  }
}

data "aws_subnet_ids" "public_subnet_ids" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Environment = var.environment
    "Public" = true
  }
}

data "aws_subnet_ids" "varnish_subnet_ids" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Environment = var.environment
    Public = false
    Name = "Varnish-Server-Production-us-east*"
  }
}

data "aws_subnet_ids" "sf_subnet_ids" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Environment = var.environment
    Public = false
    Name = "SF-Servers-Production-us-east*"
  }
}

data "aws_subnet_ids" "api_subnet_ids" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Environment = var.environment
    Public = false
    Name = "API-Servers-Production-us-east*"
  }
}

data "aws_subnet_ids" "bo_subnet_ids" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Environment = var.environment
    Public = false
    Name = "BO-Servers-Production-us-east*"
  }
}

data "aws_subnet_ids" "cron_subnet_ids" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Environment = var.environment
    Public = false
    Name = "Cron-server-Production-us-east*"
  }
}

data "aws_subnet_ids" "paas_subnet_ids" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Environment = var.environment
    Public = false
    Name = "PaaS-Services-Production-us-east*"
  }
}

data "template_file" "varnish_alb_policy" {
  template = file(".\\policies\\alb-s3.json")

  vars = {
    bucket_name = "vue.test-alb-logs"
  }
}

data "aws_iam_instance_profile" "full_s3_access" {
  name = "full-s3-access"
}