resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = join("-", [var.application_prefix, var.env, var.oac_name])
  description                       = "s3 bucket oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "s3_cloudfront" {
  enabled = true
  
  origin {
    origin_id = var.s3_origin_id
    domain_name = var.s3_origin_name
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id = var.s3_origin_id

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl = 0
    default_ttl = 86400
    max_ttl = 31536000
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations = ["JP"]
    }
  }

  aliases = ["${data.aws_acm_certificate.s3_image_acm.domain}"]

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn = data.aws_acm_certificate.s3_image_acm.arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  web_acl_id = var.web_acl_id
  tags = {
    Name = "S3 cloudfront"
    env = var.env
    resource = "cloudfront"
  }
}

resource "aws_cloudfront_distribution" "applicaiton_cloudfront" {
    aliases                         = var.aliases
    continuous_deployment_policy_id = null
    enabled                         = true
    is_ipv6_enabled                 = true
    price_class                     = "PriceClass_All"
    retain_on_delete                = false
    staging                         = false
    tags                            = {
      Name = "application cloudfront"
      env = var.env
      resource = "cloudfront"
    }
    wait_for_deployment             = true
    web_acl_id                      = var.applicaiton_waf_id

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
        target_origin_id           = var.alb_id
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
        target_origin_id           = var.alb_id
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
        target_origin_id           = var.alb_id
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
        target_origin_id           = var.alb_id
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
        target_origin_id           = var.alb_id
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
        target_origin_id           = var.alb_id
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
        target_origin_id           = var.alb_id
        trusted_key_groups         = []
        trusted_signers            = []
        viewer_protocol_policy     = "allow-all"
    }

    origin {
        connection_attempts      = 3
        connection_timeout       = 10
        domain_name              = var.alb_id
        origin_access_control_id = null
        origin_id                = var.alb_id
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
        acm_certificate_arn            = var.us1_acm_arn
        cloudfront_default_certificate = false
        iam_certificate_id             = null
        minimum_protocol_version       = "TLSv1.2_2021"
        ssl_support_method             = "sni-only"
    }
}