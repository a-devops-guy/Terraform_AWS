resource "aws_s3_bucket" "alb_log_bucket" {
  bucket = "vue.test-alb-logs"
  acl = "private"
  policy = data.template_file.varnish_alb_policy.rendered

  lifecycle_rule {
      enabled = true
      transition {
          days = 365
          storage_class = "GLACIER"
      }
      transition {
          days = 730
          storage_class = "DEEP_ARCHIVE"
      }
      expiration {
          days = 1825
      }
  }

  tags = {
      "Name" = "${var.environment}-alb-log-bucket"
      "Environment" = var.environment
  }
}