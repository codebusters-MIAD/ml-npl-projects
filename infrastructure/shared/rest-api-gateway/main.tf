#=======================================================================================================================
# API GATEWAY MODULE
# TODO Make it generic using openapi 3.0
#=======================================================================================================================
locals {
  domain_name = "${var.api_gateway_domain_name}.${var.domain}"
  tags        = {
    App         = var.tags.app
    TID         = var.tags.tid
    BUDGETID    = var.tags.budget_id
    SERVICEID   = var.tags.service_id
    ENVIRONMENT = var.environment
  }
}

resource "aws_api_gateway_rest_api" "api_gateway_rest_api" {
  name = var.tag_name

  endpoint_configuration {
    types = var.rest_api_gw_endpoint_cfg
  }

  tags = local.tags
}

resource "aws_api_gateway_domain_name" "api_gateway_domain_name" {
  domain_name              = local.domain_name
  regional_certificate_arn = var.acm_certificate_validation

  endpoint_configuration {
    types = var.rest_api_gw_endpoint_cfg
  }

  tags = local.tags
}

resource "aws_api_gateway_gateway_response" "test" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_rest_api.id
  response_type = "INTEGRATION_TIMEOUT"
  status_code   = "200"

  response_templates = {
    "application/json" = "{\"message\":\"Review lambda execution from Logs and DB stats, API gateway has a default timeout of 29 seconds\",\"requestId\":\"$context.extendedRequestId\",\"status\":$context.error.messageString}"
  }
}

resource "aws_api_gateway_base_path_mapping" "api_gateway_base_path_mapping" {
  api_id      = aws_api_gateway_rest_api.api_gateway_rest_api.id
  stage_name  = aws_api_gateway_stage.api_gateway_stage.stage_name
  domain_name = aws_api_gateway_domain_name.api_gateway_domain_name.domain_name
}

resource "aws_api_gateway_resource" "aws_api_gateway_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_rest_api.id
  parent_id   = aws_api_gateway_rest_api.api_gateway_rest_api.root_resource_id
  path_part   = var.api_gateway_rest_api_resource_path
}

resource "aws_api_gateway_stage" "api_gateway_stage" {
  deployment_id      = aws_api_gateway_deployment.api_gateway_deployment.id
  rest_api_id        = aws_api_gateway_rest_api.api_gateway_rest_api.id
  stage_name         = var.api_gateway_stage_name
  cache_cluster_size = "0.5"
  tags               = local.tags
  lifecycle {
    ignore_changes = [deployment_id]
  }
}

/**
 * This is an essential part of the fix. We need this module to create
 * the OPTION method on the same resource defined above. This is needed
 * for the preflighted requests.
 *
 * We don't have to setup the headers on the OPTIONS response here because
 * the module will take care of it.
 *
 * Source: https://github.com/squidfunk/terraform-aws-api-gateway-enable-cors
 */
# module "cors" {
#   source  = "squidfunk/api-gateway-enable-cors/aws"
#   version = "0.3.3"
#
#   api_id            = aws_api_gateway_rest_api.api_gateway_rest_api.id
#   api_resource_id   = aws_api_gateway_resource.aws_api_gateway_resource.id
#   allow_credentials = false
# }

# TODO Error AccessDenied: User: arn:aws:sts::179020893316:assumed-role/AWSReservedSSO_mstar-operator is not authorized to access this resource
# TODO It was configured manually.
# Record: https://annotation-tool-dev-api-tl
#resource "aws_route53_record" "route53_record" {
#  name    = aws_api_gateway_domain_name.api_gateway_domain_name.domain_name
#  type    = "A"
#  zone_id = aws_api_gateway_domain_name.api_gateway_domain_name.cloudfront_zone_id
#
#  alias {
#    name                   = aws_api_gateway_domain_name.api_gateway_domain_name.domain_name
#    zone_id                = aws_api_gateway_domain_name.api_gateway_domain_name.cloudfront_zone_id
#    evaluate_target_health = false
#  }
#}