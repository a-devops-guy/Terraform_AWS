resource "aws_instance" "ec2" {
    ami = var.ami_id
    associate_public_ip_address = false
    disable_api_termination = false
    hibernation = false
    #ebs_optimized = true - not applicable for t2.micro
    iam_instance_profile = var.iam_instance_profile
    instance_type = "t2.micro"
    instance_initiated_shutdown_behavior = "stop"
    key_name = "app"
    metadata_options {
        http_endpoint = "enabled"
        http_tokens = "optional"
    }
    monitoring = false
    placement_group = var.placement_group
    vpc_security_group_ids = var.ec2_security_groups
    source_dest_check = true
    subnet_id = var.ec2_subnet_id
    user_data = var.user_data
    root_block_device {
        volume_size = 8
        volume_type = "gp2"
        tags = {
            "Name" = "${var.name}-${var.environment}-root-volume"
            "Environment" = var.environment
        }
    }

    tags = {
        "Name" = "${var.name}-${var.environment}-instance"
        "Environment" = var.environment
    }
}

resource "aws_lb_target_group_attachment" "ec2_tg_attachment" {
    depends_on = [ aws_instance.ec2 ]

    target_group_arn = var.target_group_arn
    target_id = aws_instance.ec2.id
    port = var.target_group_port
}