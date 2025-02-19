locals {
  private_subnet_cidr = [for s in data.aws_subnet.private : s.cidr_block]
  public_subnet_cidr  = [for s in data.aws_subnet.public : s.cidr_block]

  web_acl_rules = {
    ## AWS-AWSManagedRulesAmazonIpReputationList
    AWS-AWSManagedRulesAmazonIpReputationList = {
      name     = "AWS-AWSManagedRulesAmazonIpReputationList"
      priority = 0

      override_action = [{ none = [{}] }]

      visibility_config = [
        {
          cloudwatch_metrics_enabled = true
          metric_name                = "AWS-AWSManagedRulesAmazonIpReputationList"
          sampled_requests_enabled   = true
        }
      ]

      statement = [
        {
          managed_rule_group_statement = [
            {
              name        = "AWSManagedRulesAmazonIpReputationList"
              vendor_name = "AWS"
            }
          ]
        }
      ]
    },
  }
}

