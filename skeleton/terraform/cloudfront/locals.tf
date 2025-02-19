locals {
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