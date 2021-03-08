module "varnish_alb" {
    source = "../../module/load-balancer" 
    depends_on = [ aws_s3_bucket.alb_log_bucket ]

    name = "varnish"
    environment = var.environment
    is_internal = false
    alb_sg = [aws_security_group.varnish.id]
    alb_subnets = data.aws_subnet_ids.varnish_subnet_ids.ids
    target_group_port = 80
    target_group_protocol = "HTTP"
    protocol_version = "HTTP1"
    vpc_id = module.vpc.vpc_id
    bucket_name = aws_s3_bucket.alb_log_bucket.bucket_domain_name
}

resource "aws_lb_listener" "varnish_alb_listener" {
    depends_on = [ module.varnish_alb ]
    load_balancer_arn = module.varnish_alb.alb_arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = module.varnish_alb.target_group_arn
    }
}

module "sf_alb" {
    source = "../../module/load-balancer"
    depends_on = [ aws_s3_bucket.alb_log_bucket ]

    name = "sf"
    environment = var.environment
    is_internal = false
    alb_sg = [aws_security_group.SF.id]
    alb_subnets = data.aws_subnet_ids.sf_subnet_ids.ids
    target_group_port = 3000
    target_group_protocol = "HTTP"
    protocol_version = "HTTP1"
    vpc_id = module.vpc.vpc_id
    bucket_name = aws_s3_bucket.alb_log_bucket.bucket_domain_name
}

resource "aws_lb_listener" "sf_alb_listener" {
    depends_on = [ module.sf_alb ]
    load_balancer_arn = module.sf_alb.alb_arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = module.sf_alb.target_group_arn
    }
}

module "api_alb" {
    source = "../../module/load-balancer"
    depends_on = [ aws_s3_bucket.alb_log_bucket ]
    
    name = "api"
    environment = var.environment
    is_internal = false
    alb_sg = [aws_security_group.API.id]
    alb_subnets = data.aws_subnet_ids.api_subnet_ids.ids
    target_group_port = 8080
    target_group_protocol = "HTTP"
    protocol_version = "HTTP1"
    vpc_id = module.vpc.vpc_id
    bucket_name = aws_s3_bucket.alb_log_bucket.bucket_domain_name
}

resource "aws_lb_listener" "api_alb_listener" {
    depends_on = [ module.api_alb ]
    load_balancer_arn = module.api_alb.alb_arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = module.api_alb.target_group_arn
    }
}

module "bo_alb" {
    source = "../../module/load-balancer"
    depends_on = [ aws_s3_bucket.alb_log_bucket ]
    
    name = "bo"
    environment = var.environment
    is_internal = false
    alb_sg = [aws_security_group.BO.id]
    alb_subnets = data.aws_subnet_ids.bo_subnet_ids.ids
    target_group_port = 80
    target_group_protocol = "HTTP"
    protocol_version = "HTTP1"
    vpc_id = module.vpc.vpc_id
    bucket_name = aws_s3_bucket.alb_log_bucket.bucket_domain_name
}

resource "aws_lb_listener" "bo_alb_listener" {
    depends_on = [ module.bo_alb ]
    load_balancer_arn = module.bo_alb.alb_arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = module.bo_alb.target_group_arn
    }
}