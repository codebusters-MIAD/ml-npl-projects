#=======================================================================================================================
# (MANDATORY) - INPUT VARIABLES - API GATEWAY
#=======================================================================================================================
variable "environment" { type = string }
variable "domain" { type = string }
variable "lambda_function_arn" { type = string }
variable "lambda_function_name" { type = string }
variable "aws_region" { type = string }
variable "api_gateway_rest_api_resource_path" { type = string }
variable "acm_certificate_validation" { type = string }
variable "api_gateway_domain_name" { type = string }
# API KEY
variable "api_gateway_api_key_name" { type = string }
variable "api_gateway_usage_plan_name" { type = string }
variable "api_gateway_usage_plan_description" { type = string }

#TAGS
variable "tag_name" {}
variable "tags" {
  type = object({ app = string, team = string, tid = string, budget_id = string, service_id = string })
}

#=======================================================================================================================
# (OPTIONAL) - INPUT VARIABLES - API GATEWAY
#=======================================================================================================================

variable "rest_api_gw_endpoint_cfg" {
  type    = list(string)
  default = ["REGIONAL"]
}

variable "method" {
  default = "METHOD"
}

variable "integration_type" {
  default = "MOCK"
}

variable "api_gateway_method_auth" {
  default = "NONE"
}

variable "api_gateway_http_post_method" {
  default = "POST"
}

variable "api_gateway_http_post_options" {
  default = "OPTIONS"
}

variable "api_gateway_http_integration_method" {
  default = "POST"
}

variable "api_key_required" {
  default = true
  type    = bool
}

variable "api_gateway_http_integration_type" {
  default = "AWS_PROXY"
}

variable "api_gateway_http_delete_method" {
  default = "DELETE"
}

variable "api_gateway_stage_name" {
  default = "dev"
}

# Lambda permissions
variable "lambda_permissions_statement_id" {
  default = "AllowAPIGatewayInvoke"
}

variable "lambda_permissions_action" {
  default = "lambda:InvokeFunction"
}

variable "lambda_permissions_principal" {
  default = "apigateway.amazonaws.com"
}

# API KEY
variable "api_gateway_usage_plan_key_type" {
  default = "API_KEY"
}

variable "usage_plan_burst_limit" {
  default = 5000
}

variable "usage_plan_rate_limit" {
  default = 10000
}

variable "method_response_code" {
  default = "200"
}

variable "response_content_type" {
  default = {
    "application/json" = "Empty"
  }
}

variable "convert_to_text" {
  default = "CONVERT_TO_TEXT"
}
