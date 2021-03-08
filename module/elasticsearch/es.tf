resource "aws_elasticsearch_domain" "es" {
    domain_name = var.domain_name
    ebs_options {
        ebs_enabled = true
        volume_type = "gp2"
        volume_size = 10
    }
    elasticsearch_version = 7.9
    advanced_security_options {
        enabled = true
        internal_user_database_enabled = true
        master_user_options {
            master_user_name = "root"
            master_user_password = "password"
        }
    }
    cluster_config {
        instance_type = var.instance_type
        instance_count = var.instance_count
        dedicated_master_enabled = true
        dedicated_master_type = var.instance_type
        dedicated_master_count = 3
        zone_awareness_enabled = true
        zone_awareness_config {
            availability_zone_count = var.instance_count
        }
    }
    vpc_options {
        security_group_ids = var.security_group_ids
        subnet_ids = var.subnet_ids
    }
    domain_endpoint_options {
        enforce_https = true
        tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
    }
    node_to_node_encryption {
        enabled = true
    }
    encrypt_at_rest {
      enabled = true
      kms_key_id = "aws/es"
    }
    snapshot_options {
        automated_snapshot_start_hour = 1
    }
    # log_publishing_options {
    #     enabled = false
    #     log_type = [ INDEX_SLOW_LOGS, SEARCH_SLOW_LOGS, ES_APPLICATION_LOGS, AUDIT_LOGS ]
    # }
}

resource "aws_elasticsearch_domain_policy" "es_policy" {
  domain_name = aws_elasticsearch_domain.es.domain_name

  depends_on = [ aws_elasticsearch_domain.es ]
  access_policies = <<POLICIES
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "es:*"
      ],
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": [
            "*"
          ]
        }
      },
      "Resource": "arn:aws:es:us-east-1:378425785477:domain/${aws_elasticsearch_domain.es.domain_name}/*"
    }
  ]
}
POLICIES
}