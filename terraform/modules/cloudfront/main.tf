provider "aws" {
  region = "us-east-1"
}

resource "aws_cloudfront_distribution" "shomotsu_distribution" {
  enabled = var.enabled
  
  origin {
    origin_id = var.origin_id
    domain_name = var.domain_name
    origin_access_control_id = var.origin_access_control_id
  }

  default_cache_behavior {
    allowed_methods        = var.allowed_methods
    cached_methods         = var.cached_methods
    target_origin_id = var.target_origin_id

    forwarded_values {
      query_string = var.forwarded_values_query_string
      cookies {
        forward = var.forwarded_values_cookies_forward
      }
    }

    viewer_protocol_policy = var.viewer_protocol_policy
    min_ttl = var.min_ttl
    default_ttl = var.default_ttl
    max_ttl = var.max_ttl
  }

  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
      locations = ["JP"]
    }
  }

  aliases = ["${data.aws_acm_certificate.s3_acm.domain}"]

  viewer_certificate {
    cloudfront_default_certificate = var.cloudfront_default_certificate
    acm_certificate_arn = data.aws_acm_certificate.s3_acm.arn
    ssl_support_method = var.ssl_support_method
    minimum_protocol_version = var.minimum_protocol_version
  }

  web_acl_id = var.web_acl_id
  tags = var.tags
}

resource "aws_cloudfront_distribution" "shomotsu_cloudfront" {
    aliases                         = [
        "api.shomotsu.net",
    ]
    continuous_deployment_policy_id = null
    enabled                         = true
    is_ipv6_enabled                 = true
    price_class                     = "PriceClass_All"
    retain_on_delete                = false
    staging                         = false
    tags                            = var.tags
    wait_for_deployment             = true
    web_acl_id                      = var.app_acl_id

    default_cache_behavior {
        allowed_methods            = [
            "DELETE",
            "GET",
            "HEAD",
            "OPTIONS",
            "PATCH",
            "POST",
            "PUT",
        ]
        cache_policy_id            = "83da9c7e-98b4-4e11-a168-04f0df8e2c65"
        cached_methods             = [
            "GET",
            "HEAD",
        ]
        compress                   = true
        default_ttl                = 0
        field_level_encryption_id  = null
        max_ttl                    = 0
        min_ttl                    = 0
        origin_request_policy_id   = "216adef6-5c7f-47e4-b989-5492eafa07d3"
        realtime_log_config_arn    = null
        response_headers_policy_id = null
        smooth_streaming           = false
        target_origin_id           = var.shomotsu_alb
        trusted_key_groups         = []
        trusted_signers            = []
        viewer_protocol_policy     = "allow-all"
    }

    ordered_cache_behavior {
        allowed_methods            = [
            "GET",
            "HEAD",
        ]
        cache_policy_id            = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        cached_methods             = [
            "GET",
            "HEAD",
        ]
        compress                   = false
        default_ttl                = 0
        field_level_encryption_id  = null
        max_ttl                    = 0
        min_ttl                    = 0
        origin_request_policy_id   = "216adef6-5c7f-47e4-b989-5492eafa07d3"
        path_pattern               = "/*.js"
        realtime_log_config_arn    = null
        response_headers_policy_id = null
        smooth_streaming           = false
        target_origin_id           = var.shomotsu_alb
        trusted_key_groups         = []
        trusted_signers            = []
        viewer_protocol_policy     = "allow-all"
    }
    ordered_cache_behavior {
        allowed_methods            = [
            "GET",
            "HEAD",
        ]
        cache_policy_id            = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        cached_methods             = [
            "GET",
            "HEAD",
        ]
        compress                   = false
        default_ttl                = 0
        field_level_encryption_id  = null
        max_ttl                    = 0
        min_ttl                    = 0
        origin_request_policy_id   = "216adef6-5c7f-47e4-b989-5492eafa07d3"
        path_pattern               = "/*.jpg"
        realtime_log_config_arn    = null
        response_headers_policy_id = null
        smooth_streaming           = false
        target_origin_id           = var.shomotsu_alb
        trusted_key_groups         = []
        trusted_signers            = []
        viewer_protocol_policy     = "allow-all"
    }
    ordered_cache_behavior {
        allowed_methods            = [
            "GET",
            "HEAD",
        ]
        cache_policy_id            = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        cached_methods             = [
            "GET",
            "HEAD",
        ]
        compress                   = false
        default_ttl                = 0
        field_level_encryption_id  = null
        max_ttl                    = 0
        min_ttl                    = 0
        origin_request_policy_id   = "216adef6-5c7f-47e4-b989-5492eafa07d3"
        path_pattern               = "/*.jpeg"
        realtime_log_config_arn    = null
        response_headers_policy_id = null
        smooth_streaming           = false
        target_origin_id           = var.shomotsu_alb
        trusted_key_groups         = []
        trusted_signers            = []
        viewer_protocol_policy     = "allow-all"
    }
    ordered_cache_behavior {
        allowed_methods            = [
            "GET",
            "HEAD",
        ]
        cache_policy_id            = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        cached_methods             = [
            "GET",
            "HEAD",
        ]
        compress                   = false
        default_ttl                = 0
        field_level_encryption_id  = null
        max_ttl                    = 0
        min_ttl                    = 0
        origin_request_policy_id   = "216adef6-5c7f-47e4-b989-5492eafa07d3"
        path_pattern               = "/*.gif"
        realtime_log_config_arn    = null
        response_headers_policy_id = null
        smooth_streaming           = false
        target_origin_id           = var.shomotsu_alb
        trusted_key_groups         = []
        trusted_signers            = []
        viewer_protocol_policy     = "allow-all"
    }
    ordered_cache_behavior {
        allowed_methods            = [
            "GET",
            "HEAD",
        ]
        cache_policy_id            = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        cached_methods             = [
            "GET",
            "HEAD",
        ]
        compress                   = false
        default_ttl                = 0
        field_level_encryption_id  = null
        max_ttl                    = 0
        min_ttl                    = 0
        origin_request_policy_id   = "216adef6-5c7f-47e4-b989-5492eafa07d3"
        path_pattern               = "/*.css"
        realtime_log_config_arn    = null
        response_headers_policy_id = null
        smooth_streaming           = false
        target_origin_id           = var.shomotsu_alb
        trusted_key_groups         = []
        trusted_signers            = []
        viewer_protocol_policy     = "allow-all"
    }
    ordered_cache_behavior {
        allowed_methods            = [
            "GET",
            "HEAD",
        ]
        cache_policy_id            = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        cached_methods             = [
            "GET",
            "HEAD",
        ]
        compress                   = false
        default_ttl                = 0
        field_level_encryption_id  = null
        max_ttl                    = 0
        min_ttl                    = 0
        origin_request_policy_id   = "216adef6-5c7f-47e4-b989-5492eafa07d3"
        path_pattern               = "/*.png"
        realtime_log_config_arn    = null
        response_headers_policy_id = null
        smooth_streaming           = false
        target_origin_id           = var.shomotsu_alb
        trusted_key_groups         = []
        trusted_signers            = []
        viewer_protocol_policy     = "allow-all"
    }

    origin {
        connection_attempts      = 3
        connection_timeout       = 10
        domain_name              = var.shomotsu_alb
        origin_access_control_id = null
        origin_id                = var.shomotsu_alb
        origin_path              = null

        custom_origin_config {
            http_port                = 80
            https_port               = 443
            origin_keepalive_timeout = 5
            origin_protocol_policy   = "https-only"
            origin_read_timeout      = 30
            origin_ssl_protocols     = [
                "TLSv1.2",
            ]
        }
    }

    restrictions {
        geo_restriction {
            locations        = []
            restriction_type = "none"
        }
    }

    viewer_certificate {
        acm_certificate_arn            = var.us1_acm
        cloudfront_default_certificate = false
        iam_certificate_id             = null
        minimum_protocol_version       = "TLSv1.2_2021"
        ssl_support_method             = "sni-only"
    }
}