resource "aws_launch_template" "launch_template" {
    name = "${var.name}-${var.environment}-launch-template"
    default_version = var.default_version
    disable_api_termination = false
    iam_instance_profile {
        name = var.iam_instance_profile_name
    }
    image_id = var.ami_id
    instance_initiated_shutdown_behavior = "terminate"
    instance_type = "t2.micro"
    key_name = "app" 
    metadata_options {
        http_endpoint = "enabled"
        http_tokens = "optional"
    }
    monitoring {
        enabled = false
    } 
    network_interfaces {
        associate_public_ip_address = false
        delete_on_termination = true
        device_index = 0
        security_groups = var.security_groups
    }
    vpc_security_group_ids = var.security_groups
    user_data = var.user_data
    block_device_mappings {
        ebs {
            delete_on_termination = true
            volume_size = 8
            volume_type = "gp2"
        }
    }

    tag_specifications {
        resource_type = "instance"
        tags = {
          "Name" = "${var.name}-${var.environment}-asg-instance"
          "Environment" = var.environment
        }
    }

    tag_specifications {
        resource_type = "volume"
        tags = {
          "Name" = "${var.name}-${var.environment}-asg-volume"
          "Environment" = var.environment
        }
    }

    tags = {
        "Name" = "${var.name}-${var.environment}-launch-template"
        "Environment" = var.environment
    }
}