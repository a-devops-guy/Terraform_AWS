resource "aws_lb" "alb" {
    name = "${var.name}-${var.environment}-ALB"
    internal = var.is_internal
    load_balancer_type = "application"
    security_groups = var.alb_sg
    subnets = var.alb_subnets
    idle_timeout = 60
    enable_deletion_protection = false
    enable_cross_zone_load_balancing = false
    enable_http2 = false
    ip_address_type = "ipv4"

    tags = {
        "Name" = "${var.name}-${var.environment}-ALB"
        "Environment" = var.environment
        "Public" = var.is_internal == true ? true : false
    }

    access_logs {
        bucket = trimsuffix(var.bucket_name, ".s3.amazonaws.com")
        prefix = "${var.name}-alb-logs"
        enabled = true
    }
}