resource "aws_efs_file_system" "efs" {
    creation_token = "vue.test-production-media-storage"
    lifecycle_policy {
        transition_to_ia = "AFTER_7_DAYS"
    }
    tags = {
      "name" = "vue.test-production-media-storage"
      "environment" = "production"
    }
}

resource "aws_efs_mount_target" "efs_mount_sf" {
    count = length(data.aws_subnet_ids.sf_subnet_ids.ids)
    file_system_id = aws_efs_file_system.efs.id
    subnet_id = element(tolist(data.aws_subnet_ids.sf_subnet_ids.ids),count.index)
    security_groups = [ aws_security_group.efs.id ]
}

resource "aws_efs_mount_target" "efs_mount_bo" {
    count = length(data.aws_subnet_ids.bo_subnet_ids.ids)
    file_system_id = aws_efs_file_system.efs.id
    subnet_id = element(tolist(data.aws_subnet_ids.bo_subnet_ids.ids),count.index)
    security_groups = [ aws_security_group.efs.id ]
}