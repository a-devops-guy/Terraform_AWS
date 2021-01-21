resource "aws_default_route_table" "default_rt" {
    default_route_table_id = module.vpc.vpc_default_rt

    tags = {
      Name = "${var.environment}-default-rt"
      Main = true
    }
}

module "public_rt" {
  source = "../../module/networking/route/public"
  
  #tagging
  environment = var.environment
  name = "Nginx-Varnish"
  
  #./vpc.tf
  vpc_id = module.vpc.vpc_id
  ig_id = module.vpc.gw_id
}

module "private_rt" {
  source = "../../module/networking/route/private"
  
  #tagging
  environment = var.environment
  name = "App-PaaS"

  #./vpc.tf
  vpc_id = module.vpc.vpc_id
}

module "private_rts_association" {
  source = "../../module/networking/route/rt-association"
  
  #./data.tf
  count = length(data.aws_subnet_ids.private.ids)

  subnets_id = element(tolist(data.aws_subnet_ids.private.ids),count.index)
  route_table_id = module.private_rt.route_table_ids
}

module "public_rts_association" {
  source = "../../module/networking/route/rt-association"
  
  #./data.tf
  count = length(data.aws_subnet_ids.public.ids)

  subnets_id = element(tolist(data.aws_subnet_ids.public.ids),count.index)
  route_table_id = module.public_rt.route_table_ids
}