module "rt_public" {
  source = "../../module/networking/route/route-table-main"
  default_route_table_id = module.vpc.vpc_default_rt
  gw_id = module.vpc.gw_id
  name = "Prod_RT_Public"
  environment = var.environment
}

module "rt_private" {
    source = "../../module/networking/route/route-table-private"
    vpc_id = module.vpc.vpc_id
    name = "Prod_RT_Public"
    environment = var.environment
}

resource "aws_route" "public" {
  route_table_id            = module.rt_public.public_route_table_id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id  = module.vpc.gw_id
}

data "aws_subnet_ids" "public" {
  vpc_id = module.vpc.vpc_id

  filter {
    name   = "tag:Public"
    values = ["true"]
  }
}

module "rt_association_public" {
    count = length(data.aws_subnet_ids.public.ids)
    source = "../../module/networking/route/route-association"
    subnets_id = element(tolist(data.aws_subnet_ids.public.ids),count.index)
    route_table_id = module.rt_public.public_route_table_id
}

data "aws_subnet_ids" "private" {
  vpc_id = module.vpc.vpc_id

  filter {
    name   = "tag:Public"
    values = ["false"]
  }
}

module "rt_association_private" {
    count = length(data.aws_subnet_ids.private.ids)
    source = "../../module/networking/route/route-association"
    subnets_id = element(tolist(data.aws_subnet_ids.private.ids),count.index)
    route_table_id = module.rt_private.private_route_table_id
}