module "sf_asg" {
    source = "../../module/autoscaling"
    
    name = "SF"
    default_version = 1
    iam_instance_profile_name = "full-s3-access" #
    ami_id = "ami-042e8287309f5df03" #
    security_groups = data.aws_subnet_ids.sf_subnet_ids.ids
    user_data = file(".\\scripts\\user-data.sh")
    placement_group = aws_placement_group.spread_strategy.id
    environment = var.environment
    subnet_ids = data.aws_subnet_ids.sf_subnet_ids.ids
    launch_template_id = module.sf_asg.launch_template_id
    target_group_arns = toset([module.sf_alb.target_group_arn])
}

module "api_asg" {
    source = "../../module/autoscaling"
    
    name = "API"
    default_version = 1
    iam_instance_profile_name = "full-s3-access" #
    ami_id = "ami-042e8287309f5df03" #
    security_groups = data.aws_subnet_ids.api_subnet_ids.ids
    user_data = file(".\\scripts\\user-data.sh")
    placement_group = aws_placement_group.spread_strategy.id
    environment = var.environment
    subnet_ids = data.aws_subnet_ids.api_subnet_ids.ids
    launch_template_id = module.api_asg.launch_template_id
    target_group_arns = toset([module.api_alb.target_group_arn])
}