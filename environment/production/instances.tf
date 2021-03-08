module "varnish_instances" {
    source = "../../module/instance"
    depends_on = [ module.varnish_alb, aws_lb_listener.varnish_alb_listener, aws_placement_group.spread_strategy ]
    
    count = length(data.aws_subnet_ids.varnish_subnet_ids.ids)
    name = "varnish"
    ami_id = "ami-042e8287309f5df03" #
    iam_instance_profile = "full-s3-access" #
    placement_group = aws_placement_group.spread_strategy.id
    ec2_security_groups = [ aws_security_group.varnish.id ]
    ec2_subnet_id = element(tolist(data.aws_subnet_ids.varnish_subnet_ids.ids), count.index)
    user_data = file(".\\scripts\\user-data.sh")
    environment = var.environment
    target_group_arn = module.varnish_alb.target_group_arn
    target_group_port =  module.varnish_alb.target_group_port
}

module "bo_instances" {
    source = "../../module/instance"
    depends_on = [ module.bo_alb, aws_lb_listener.bo_alb_listener, aws_placement_group.spread_strategy ]

    count = length(data.aws_subnet_ids.bo_subnet_ids.ids)*2
    name = "BO"
    ami_id = "ami-042e8287309f5df03" #
    iam_instance_profile = "full-s3-access" #
    placement_group = aws_placement_group.spread_strategy.id
    ec2_security_groups = [ aws_security_group.BO.id ]
    ec2_subnet_id = element(tolist(data.aws_subnet_ids.bo_subnet_ids.ids), count.index)
    user_data = file(".\\scripts\\user-data.sh")
    environment = var.environment
    target_group_arn = module.varnish_alb.target_group_arn
    target_group_port =  module.varnish_alb.target_group_port
}

resource "aws_instance" "cron_instances" {
    count = 2
    depends_on = [ aws_placement_group.spread_strategy ]
    
    ami = "ami-042e8287309f5df03" #
    associate_public_ip_address = false
    disable_api_termination = false
    hibernation = false
    #ebs_optimized = true - not applicable for t2.micro
    iam_instance_profile = "full-s3-access" #
    instance_type = "t2.micro"
    instance_initiated_shutdown_behavior = "stop"
    key_name = "app"
    metadata_options {
        http_endpoint = "enabled"
        http_tokens = "optional"
    }
    monitoring = false
    placement_group = aws_placement_group.spread_strategy.id
    vpc_security_group_ids = [ aws_security_group.BO.id ]
    source_dest_check = true
    subnet_id = element(tolist(data.aws_subnet_ids.bo_subnet_ids.ids), count.index)
    user_data = file(".\\scripts\\user-data.sh")
    root_block_device {
        volume_size = 8
        volume_type = "gp2"
        tags = {
            "Name" = "cron-${var.environment}-root-volume"
            "Environment" = var.environment
        }
    }

    tags = {
        "Name" = "cron-${var.environment}-instance"
        "Environment" = var.environment
    }
}

resource "aws_instance" "bastion_instances" {
    count = 2
    depends_on = [ aws_placement_group.spread_strategy ]
    
    ami = "ami-042e8287309f5df03" #
    associate_public_ip_address = true
    disable_api_termination = false
    hibernation = false
    #ebs_optimized = true - not applicable for t2.micro
    iam_instance_profile = "full-s3-access" #
    instance_type = "t2.micro"
    instance_initiated_shutdown_behavior = "stop"
    key_name = "app"
    metadata_options {
        http_endpoint = "enabled"
        http_tokens = "optional"
    }
    monitoring = false
    placement_group = aws_placement_group.spread_strategy.id
    vpc_security_group_ids = [ aws_security_group.public.id ]
    source_dest_check = true
    subnet_id = element(tolist(data.aws_subnet_ids.public_subnet_ids.ids), count.index)
    user_data = file(".\\scripts\\user-data.sh")
    root_block_device {
        volume_size = 8
        volume_type = "gp2"
        tags = {
            "Name" = "bastion-${var.environment}-root-volume"
            "Environment" = var.environment
        }
    }

    tags = {
        "Name" = "bastion-${var.environment}-instance"
        "Environment" = var.environment
    }
}