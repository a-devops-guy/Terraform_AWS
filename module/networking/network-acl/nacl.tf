resource "aws_network_acl" "nacl" {
    vpc_id = var.vpc_id
    subnet_ids = var.subnet_ids

    dynamic "ingress" {
      for_each = flatten([for i in var.ingress_rules : {
        from_port = i.from_port
        to_port = i.to_port
        rule_no    = i.rule_no
        cidr = i.cidr
        protocol = i.protocol
        action = i.action
      }])
      content {
        protocol   = ingress.value["protocol"]
        rule_no    = ingress.value["rule_no"]
        action     = ingress.value["action"]
        cidr_block = ingress.value["cidr"]
        from_port  = ingress.value["from_port"]
        to_port    = ingress.value["to_port"]
      }
  }

  dynamic "egress" {
    for_each = flatten([for i in var.egress_rules : {
        from_port = i.from_port
        to_port = i.to_port
        rule_no = i.rule_no
        cidr = i.cidr
        protocol = i.protocol
        action = i.action
      }])
      content {
        protocol   = egress.value["protocol"]
        rule_no    = egress.value["rule_no"]
        action     = egress.value["action"]
        cidr_block = egress.value["cidr"]
        from_port  = egress.value["from_port"]
        to_port    = egress.value["to_port"]
      }
  }

  tags = {
    "Name" = "${var.environment}-${var.name}-nacl"
    "Environment" = var.environment
  }
}