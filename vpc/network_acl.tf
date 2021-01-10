locals {
  nacl_rules = [
    { port : var.HTTPS,   rule_num : 101, cidr : aws_subnet.private_az1.cidr_block },
    { port : var.HTTPS,   rule_num : 102, cidr : aws_subnet.private_az2.cidr_block },
    { port : var.HTTPS,   rule_num : 103, cidr : aws_subnet.public_az1.cidr_block },
    { port : var.HTTPS,   rule_num : 104, cidr : aws_subnet.public_az2.cidr_block }
  ]
}

resource "aws_default_network_acl" "default" {
    default_network_acl_id = aws_vpc.prod_vpc.default_network_acl_id
    subnet_ids = [ aws_subnet.public_az1.id, aws_subnet.public_az2.id ]

    dynamic "ingress" {
    for_each = [for rule_obj in local.nacl_rules : {
      port       = rule_obj.port
      rule_no    = rule_obj.rule_num
      cidr_block = rule_obj.cidr
    }]
    content {
      protocol   = "tcp"
      rule_no    = ingress.value["rule_no"]
      action     = "allow"
      cidr_block = ingress.value["cidr_block"]
      from_port  = ingress.value["port"]
      to_port    = ingress.value["port"]
    }
  }

  dynamic "egress" {
    for_each = [for rule_obj in local.nacl_rules : {
      port       = rule_obj.port
      rule_no    = rule_obj.rule_num
      cidr_block = rule_obj.cidr
    }]
    content {
      protocol   = "tcp"
      rule_no    = egress.value["rule_no"]
      action     = "allow"
      cidr_block = egress.value["cidr_block"]
      from_port  = egress.value["port"]
      to_port    = egress.value["port"]
    }
  }

  tags = {
    "Name" = "Public_NACL"
    "Environment" = "Production"
  }
}

locals {
  nacl_pvt_rules = [
    { port : var.SF_PORT,   rule_num : 101, cidr : aws_subnet.private_az1.cidr_block },
    { port : var.SF_PORT,   rule_num : 102, cidr : aws_subnet.private_az2.cidr_block },
    { port : var.API_PORT,   rule_num : 201, cidr : aws_subnet.private_az1.cidr_block },
    { port : var.API_PORT,   rule_num : 202, cidr : aws_subnet.private_az2.cidr_block },
    { port : var.HTTPS,   rule_num : 301, cidr : aws_subnet.private_az1.cidr_block },
    { port : var.HTTPS,   rule_num : 302, cidr : aws_subnet.private_az2.cidr_block },
    { port : var.HTTPS,   rule_num : 301, cidr : aws_subnet.public_az1.cidr_block },
    { port : var.HTTPS,   rule_num : 302, cidr : aws_subnet.public_az2.cidr_block },
    { port : var.MYSQL_PORT,  rule_num : 401, cidr : aws_subnet.private_az1.cidr_block },
    { port : var.MYSQL_PORT,  rule_num : 402, cidr : aws_subnet.private_az2.cidr_block },
    { port : var.REDIS_PORT,  rule_num : 501, cidr : aws_subnet.private_az1.cidr_block },
    { port : var.REDIS_PORT,  rule_num : 502, cidr : aws_subnet.private_az2.cidr_block },
    { port : var.RABBITMQ_PORT,  rule_num : 601, cidr : aws_subnet.private_az1.cidr_block },
    { port : var.RABBITMQ_PORT,  rule_num : 602, cidr : aws_subnet.private_az2.cidr_block }
  ]
}

resource "aws_default_network_acl" "private_nacl" {
    default_network_acl_id = aws_vpc.prod_vpc.default_network_acl_id
    subnet_ids = [ aws_subnet.private_az1.id, aws_subnet.private_az2.id ]

    dynamic "ingress" {
    for_each = [for rule_obj in local.nacl_pvt_rules : {
      port       = rule_obj.port
      rule_no    = rule_obj.rule_num
      cidr_block = rule_obj.cidr
    }]
    content {
      protocol   = "tcp"
      rule_no    = ingress.value["rule_no"]
      action     = "allow"
      cidr_block = ingress.value["cidr_block"]
      from_port  = ingress.value["port"]
      to_port    = ingress.value["port"]
    }
  }

  dynamic "egress" {
    for_each = [for rule_obj in local.nacl_pvt_rules : {
      port       = rule_obj.port
      rule_no    = rule_obj.rule_num
      cidr_block = rule_obj.cidr
    }]
    content {
      protocol   = "tcp"
      rule_no    = egress.value["rule_no"]
      action     = "allow"
      cidr_block = egress.value["cidr_block"]
      from_port  = egress.value["port"]
      to_port    = egress.value["port"]
    }
  }

  tags = {
    "Name" = "Private_NACL"
    "Environment" = "Production"
  }
}