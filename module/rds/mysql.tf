resource "aws_db_instance" "mysql" {
    allocated_storage  = 20
    allow_major_version_upgrade = false
    apply_immediately  = true
    backup_retention_period = 35
    backup_window = "12:00-01:00"
    auto_minor_version_upgrade = false
    #availability_zone = var.az
    copy_tags_to_snapshot = true
    db_subnet_group_name = aws_db_subnet_group.mysql_subnets.name
    delete_automated_backups = false
    deletion_protection = true
    engine = "mysql"
    engine_version = "8.0.21"
    final_snapshot_identifier = "final-snapshot"
    skip_final_snapshot = false
    identifier = var.rds_name
    maintenance_window = "Sun:01:00-Sun:02:00"
    instance_class = "db.m3.medium"
    max_allocated_storage = 0 #disable auto scaling
    name = var.db_name
    multi_az = true
    option_group_name = var.option_group_name
    parameter_group_name = var.parameter_group_name
    password = var.password
    performance_insights_enabled = true
    publicly_accessible = false
    storage_type = "gp2"
    username = "root"
    vpc_security_group_ids = var.vpc_security_group_ids
}

resource "aws_db_subnet_group" "mysql_subnets" {
  name       = "db_subnet"
  subnet_ids = var.subnet_ids
}
