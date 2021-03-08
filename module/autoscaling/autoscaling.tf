resource "aws_autoscaling_group" "asg" {
    depends_on = [ aws_launch_template.launch_template ]

    name = "${var.name}-${var.environment}-asg"
    max_size = 4
    min_size = 1
    desired_capacity = 2
    vpc_zone_identifier = var.subnet_ids
    launch_template {
        id = var.launch_template_id
        version = "$Latest"
    }
    placement_group = var.placement_group
    health_check_type = "ELB"
    force_delete = true
    target_group_arns = var.target_group_arns
    termination_policies = [ "NewestInstance" ]
    suspended_processes = [ "Launch", "Terminate", "HealthCheck", "ReplaceUnhealthy" ]
}