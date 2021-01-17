data "aws_subnet" "public_subnet" {
  for_each = data.aws_subnet_ids.public.ids
  id = each.value
}

data "aws_subnet" "private_subnet" {
  for_each = data.aws_subnet_ids.private.ids
  id = each.value
}


module "nacl_public" {
    source = "../../module/networking/network-acl/public"
    
    default_network_acl_id = module.rt_public.public_route_table_id
    subnet_ids = data.aws_subnet_ids.public.ids
    
    #count = length(data.aws_subnet_ids.public.ids)
    environment = var.environment
    
    public_nacl_rules = [
        {
            rule_num = 100,
            cidr = ["0.0.0.0/0"],
            protocol = "tcp",
            action = "allow",
            port = 443
        },
        {
            rule_num = 200,
            cidr = [for s in data.aws_subnet.private_subnet: s.cidr_block],
            protocol = "tcp",
            action = "allow",
            port = 8080
        },
        {
            rule_num = 200,
            cidr = [for s in data.aws_subnet.private_subnet: s.cidr_block],
            protocol = "tcp",
            action = "allow",
            port = 3000
        }
    ]
}

module "nacl_private" {
    source = "../../module/networking/network-acl/private"
    
    default_network_acl_id = module.rt_private.private_route_table_id
    subnet_ids = data.aws_subnet_ids.private.ids

    environment = var.environment
    private_nacl_rules = [
        {
            rule_num = 100,
            cidr = [for s in data.aws_subnet.private_subnet: s.cidr_block],
            protocol = "tcp",
            action = "allow",
            port = 443
        },
        {
            rule_num = 100,
            cidr = [for s in data.aws_subnet.private_subnet: s.cidr_block],
            protocol = "tcp",
            action = "allow",
            port = 3306
        },
        {
            rule_num = 200,
            cidr = [for s in data.aws_subnet.private_subnet: s.cidr_block],
            protocol = "tcp",
            action = "allow",
            port = 3000
        },
        {
            rule_num = 200,
            cidr = [for s in data.aws_subnet.private_subnet: s.cidr_block],
            protocol = "tcp",
            action = "allow",
            port = 8080
        },
        {
            rule_num = 200,
            cidr = [for s in data.aws_subnet.public_subnet: s.cidr_block],
            protocol = "tcp",
            action = "allow",
            port = 3000
        },
        {
            rule_num = 200,
            cidr = [for s in data.aws_subnet.public_subnet: s.cidr_block],
            protocol = "tcp",
            action = "allow",
            port = 8080
        },
        {
            rule_num = 200,
            cidr = [for s in data.aws_subnet.private_subnet: s.cidr_block],
            protocol = "tcp",
            action = "allow",
            port = 6379
        },
        {
            rule_num = 200,
            cidr = [for s in data.aws_subnet.private_subnet: s.cidr_block],
            protocol = "tcp",
            action = "allow",
            port = 61617
        },
        {
            rule_num = 200,
            cidr = [for s in data.aws_subnet.private_subnet: s.cidr_block],
            protocol = "tcp",
            action = "allow",
            port = 5671
        },
        {
            rule_num = 200,
            cidr = [for s in data.aws_subnet.private_subnet: s.cidr_block],
            protocol = "tcp",
            action = "allow",
            port = 61614
        },
        {
            rule_num = 200,
            cidr = [for s in data.aws_subnet.private_subnet: s.cidr_block],
            protocol = "tcp",
            action = "allow",
            port = 8883
        },
        {
            rule_num = 200,
            cidr = [for s in data.aws_subnet.private_subnet: s.cidr_block],
            protocol = "tcp",
            action = "allow",
            port = 61619
        }
    ]
}