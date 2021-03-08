resource "aws_lb_target_group" "alb_target_group" {
  depends_on = [ aws_lb.alb ]
  name        = "${var.name}-${var.environment}-target-group"
  target_type = "instance"
  port = var.target_group_port
  protocol = var.target_group_protocol
  protocol_version = var.protocol_version
  vpc_id = var.vpc_id
  deregistration_delay = 300
  slow_start = 60
  load_balancing_algorithm_type = "round_robin"
  health_check {
      enabled = true
      interval = 30
      path = "/"
      port = var.target_group_port
      protocol = var.target_group_protocol
      timeout = 5
      healthy_threshold = 2
      unhealthy_threshold = 2
      matcher = 200
  }

  tags = {
      "Name" = "${var.name}-${var.environment}-target-group"
      "Environment" = var.environment
  }
}