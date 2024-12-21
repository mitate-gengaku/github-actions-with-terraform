provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

resource "aws_wafv2_web_acl" "application_waf" {
  name        = "ApplicationWAF"
  description = "WAF for application"
  scope       = "CLOUDFRONT"

  provider = aws.us-east-1
 
  default_action {
    allow {}
  }
 
  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 10
 
    override_action {
      count {}
    }
 
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }
 
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesCommonRuleSetMetric"
      sampled_requests_enabled   = false
    }
  }
 
  rule {
    name     = "AWSManagedRulesKnownBadInputsRuleSet"
    priority = 20
 
    override_action {
      count {}
    }
 
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }
 
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesKnownBadInputsRuleSetMetric"
      sampled_requests_enabled   = false
    }
  }
 
  rule {
    name     = "AWSManagedRulesAmazonIpReputationList"
    priority = 30
 
    override_action {
      count {}
    }
 
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    }
 
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesAmazonIpReputationListMetric"
      sampled_requests_enabled   = false
    }
  }
 
  rule {
    name     = "AWSManagedRulesAnonymousIpList"
    priority = 40
 
    override_action {
      count {}
    }
 
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAnonymousIpList"
        vendor_name = "AWS"
      }
    }
 
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesAnonymousIpListMetric"
      sampled_requests_enabled   = false
    }
  }
 
  rule {
    name     = "AWSManagedRulesSQLiRuleSet"
    priority = 50
 
    override_action {
      count {}
    }
 
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }
 
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesSQLiRuleSetMetric"
      sampled_requests_enabled   = false
    }
  }
 
  rule {
    name     = "AWSManagedRulesLinuxRuleSet"
    priority = 60
 
    override_action {
      count {}
    }
 
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesLinuxRuleSet"
        vendor_name = "AWS"
      }
    }
 
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesLinuxRuleSetMetric"
      sampled_requests_enabled   = false
    }
  }
 
  rule {
    name     = "AWSManagedRulesUnixRuleSet"
    priority = 70
 
    override_action {
      count {}
    }
 
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesUnixRuleSet"
        vendor_name = "AWS"
      }
    }
 
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesUnixRuleSetMetric"
      sampled_requests_enabled   = false
    }
  }
 
  rule {
    name     = "AWSRateBasedRule"
    priority = 2
 
    action {
      count {}
    }
 
    statement {
      rate_based_statement {
        limit              = 500
        aggregate_key_type = "IP"
 
        scope_down_statement {
          geo_match_statement {
            country_codes = ["US", "NL"]
          }
        }
      }
    }
 
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSRateBasedRuleMetric"
      sampled_requests_enabled   = false
    }
  }
 
  rule {
    name     = "DisableOverseasIP"
    priority = 1

    action {
      block {}
    }

    statement {
      not_statement {
        statement {
          geo_match_statement {
            country_codes = ["JP"]
          }
        }
      }
    }
 
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "waf_oversear"
      sampled_requests_enabled   = false
    }
  }

  tags = {
    Name = "ApplicationWAF"
    env = var.env
    resource = "waf"
  }
 
  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "applicationWAFMetric"
    sampled_requests_enabled   = false
  }
}
resource "aws_wafv2_web_acl" "cloudfront_image_waf" {
  name        = "CloudfrontImageWAF"
  description = "WAF for Cloudfront"
  scope       = "CLOUDFRONT"

  provider = aws.us-east-1
 
  default_action {
    allow {}
  }
 
  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 10
 
    override_action {
      count {}
    }
 
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }
 
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesCommonRuleSetMetric"
      sampled_requests_enabled   = false
    }
  }
 
  rule {
    name     = "AWSManagedRulesKnownBadInputsRuleSet"
    priority = 20
 
    override_action {
      count {}
    }
 
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }
 
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesKnownBadInputsRuleSetMetric"
      sampled_requests_enabled   = false
    }
  }
 
  rule {
    name     = "AWSManagedRulesAmazonIpReputationList"
    priority = 30
 
    override_action {
      count {}
    }
 
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    }
 
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesAmazonIpReputationListMetric"
      sampled_requests_enabled   = false
    }
  }
 
  rule {
    name     = "DisableOverseasIP"
    priority = 1

    action {
      block {}
    }

    statement {
      not_statement {
        statement {
          geo_match_statement {
            country_codes = ["JP"]
          }
        }
      }
    }
 
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "waf_oversea"
      sampled_requests_enabled   = false
    }
  }
 
  tags = {
    Name = "CloudfrontImageWAF"
    env = var.env
    resource = "waf"
  }
 
  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "CloudfrontImageWAFMetric"
    sampled_requests_enabled   = false
  }
}

resource "aws_s3_bucket" "application_log_bucket" {
  bucket = join("-", ["aws-waf-logs", var.application_prefix, var.env, "application-log-bucket"])
  
  tags = {
    Name = join("-", ["aws-waf-logs", var.application_prefix, var.env, "application-log-bucket"])
    env = var.env
    resource = "s3"
  }
}

resource "aws_s3_bucket" "cloudfront_log_bucket" {
  bucket = join("-", ["aws-waf-logs", var.application_prefix, var.env, "image-log-bucket"])
  
  tags = {
    Name = join("-", ["aws-waf-logs", var.application_prefix, var.env, "image-log-bucket"])
    env = var.env
    resource = "s3"
  }
}

resource "aws_wafv2_web_acl_logging_configuration" "application_log_config" {
  log_destination_configs = ["${aws_s3_bucket.application_log_bucket.arn}"]
  resource_arn = aws_wafv2_web_acl.application_waf.arn
  provider = aws.us-east-1

  logging_filter {
    default_behavior = "KEEP"

    filter {
      behavior = "DROP"
      condition {
        action_condition {
          action = "BLOCK"
        }
      }
      requirement = "MEETS_ANY"
    }
  }
}

resource "aws_wafv2_web_acl_logging_configuration" "cloudfront_log_config" {
  log_destination_configs = ["${aws_s3_bucket.cloudfront_log_bucket.arn}"]
  resource_arn = aws_wafv2_web_acl.cloudfront_image_waf.arn
  provider = aws.us-east-1

  logging_filter {
    default_behavior = "KEEP"

    filter {
      behavior = "DROP"
      condition {
        action_condition {
          action = "BLOCK"
        }
      }
      requirement = "MEETS_ANY"
    }
  }
}