locals {

  origins = [
    {
      origin_id     = "cloudfront-1"
      domain_name   = "test.wpengine.com"
      bucket_name   = "${var.namespace}-${var.environment}test-ui"
      create_bucket = true
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "match-viewer"
        origin_ssl_protocols   = ["TLSv1"]
      }

    }
  ]

  default_cache_behavior = {
    origin_id                               = "cloudfront-1",
    allowed_methods                         = ["GET", "HEAD"]
    cached_methods                          = ["GET", "HEAD"]
    compress                                = false
    viewer_protocol_policy                  = "redirect-to-https"
    use_aws_managed_response_headers_policy = false
    response_headers_policy_name            = "test-security-headers-policy"

    use_aws_managed_cache_policy          = true
    cache_policy_name                     = "CachingOptimized"
    use_aws_managed_origin_request_policy = true
    origin_request_policy_name            = "CORS-S3Origin" // It can be custom or aws managed policy name , if custom origin_request_policies variable key should match
    lambda_function_association = [{
      event_type   = "viewer-request"
      lambda_arn   = aws_lambda_function.this.qualified_arn
      include_body = true
    }]

  }

  response_headers_policy = {
    "test-security-headers-policy" = {
      name = "test-security-headers-policy"
      cors_config = {
        access_control_allow_credentials = true
        access_control_allow_headers = {
          items = ["test"]
        }
        access_control_allow_methods = {
          items = ["GET"]
        }
        access_control_allow_origins = {
          items = ["test.example.comtest"]
        }
        access_control_expose_headers = {
          items = []
        }
        access_control_max_age_sec = 600
        origin_override            = true
      }

      security_headers_config = {
        content_type_options = {
          override = false
        }
        frame_options = {
          frame_option = "SAMEORIGIN"
          override     = false
        }
        referrer_policy = {
          referrer_policy = "origin-when-cross-origin"
          override        = true
        }
        xss_protection = {
          mode_block = false
          protection = true
          override   = false
          report_uri = ""
        }
        strict_transport_security = {
          access_control_max_age_sec = "31536000"
          include_subdomains         = true
          preload                    = false
          override                   = false
        }
        content_security_policy = {
          content_security_policy = "frame-ancestors 'self'"
          override                = false
        }
      }
    }
  }
}
