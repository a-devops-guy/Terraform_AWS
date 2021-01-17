resource "aws_default_network_acl" "public_nacl" {
    default_network_acl_id = var.default_network_acl_id
    subnet_ids = var.subnet_ids

    dynamic "ingress" {
      for_each = flatten([for i in var.public_nacl_rules : [
        for j in range(length(i.cidr)) : {
        port       = i.port
        rule_no    = i.rule_num
        cidr_block = element(i.cidr,j)
        protocol = i.protocol
        action = i.action
      }]])
      content {
        protocol   = ingress.value["protocol"]
        rule_no    = ingress.value["rule_no"]
        action     = ingress.value["action"]
        cidr_block = ingress.value["cidr_block"]
        from_port  = ingress.value["port"]
        to_port    = ingress.value["port"]
      }
  }

  dynamic "egress" {
    for_each = flatten([for i in var.public_nacl_rules : [
        for j in range(length(i.cidr)) : {
        port       = i.port
        rule_no    = i.rule_num
        cidr_block = element(i.cidr,j)
        protocol = i.protocol
        action = i.action
      }]])
      content {
        protocol   = egress.value["protocol"]
        rule_no    = egress.value["rule_no"]
        action     = egress.value["action"]
        cidr_block = egress.value["cidr_block"]
        from_port  = egress.value["port"]
        to_port    = egress.value["port"]
      }
  }

  tags = {
    "Name" = "${var.environment}-public-nacl"
    "Environment" = var.environment
    "Public" = true
  }
}