resource "aws_mq_broker" "rmq" {
    apply_immediately = true
    auto_minor_version_upgrade = false
    broker_name = var.name
    deployment_mode = "ACTIVE_STANDBY_MULTI_AZ"
    engine_type = "ActiveMQ"
    engine_version = "3.8.6"
    host_instance_type = "mq.t3.micro"
    publicly_accessible = false
    security_groups = var.security_groups 
    subnet_ids = var.subnet_ids
    user {
        console_access = true
        password = "root11223344"
        username = "root"
        groups = [ "root" ]
    }
}