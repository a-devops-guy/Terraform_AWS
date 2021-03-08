module "redis" {
    source = "../../module/redis"
    
    environment = var.environment
    name = "vue-redis"
    sg_names = [ aws_security_group.PaaS.name ]
    subnet_group_ids = data.aws_subnet_ids.paas_subnet_ids.ids
}

module "es7" {
    source = "../../module/elasticsearch"
    
    domain_name = "vue-test"
    security_group_ids = [ aws_security_group.PaaS.id ]
    subnet_ids = data.aws_subnet_ids.paas_subnet_ids.ids
}

module "rmq" {
    source = "../../module/mq"
    
    name = "vue-mq"
    security_groups = [ aws_security_group.PaaS.id ]
    subnet_ids = data.aws_subnet_ids.paas_subnet_ids.ids
}

module "mysql" {
    source = "../../module/rds"
    
    rds_name = "vue-test"
    db_name = "magento"
    option_group_name = "default.mysql8.0"
    parameter_group_name = "default.mysql8.0"
    vpc_security_group_ids = [ aws_security_group.PaaS.id ]
    subnet_ids = data.aws_subnet_ids.paas_subnet_ids.ids
    password = "test11223344"
}