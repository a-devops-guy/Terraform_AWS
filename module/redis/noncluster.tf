resource "aws_elasticache_replication_group" "redis" {
  automatic_failover_enabled    = true
  multi_az_enabled = true
  availability_zones            = tolist(var.redis_az)
  replication_group_id          = var.name
  replication_group_description = "${var.name}-${var.environment}-redis"
  node_type                     = "cache.t2.micro"
  number_cache_clusters         = 2
  parameter_group_name          = var.parameter_group_name
  auto_minor_version_upgrade = true
  engine = "redis"
  engine_version = "redis6.x"
  security_group_names = toset([aws_elasticache_security_group.redis_sg.name])
  subnet_group_name = aws_elasticache_subnet_group.redis_subnet.name
}

resource "aws_elasticache_subnet_group" "redis_subnet" {
  name        = "redis-subnet-group"
  subnet_ids  = var.subnet_group_ids
}

resource "aws_elasticache_security_group" "redis_sg" {
  name                 = "redis-security-group"
  security_group_names = var.sg_names
}