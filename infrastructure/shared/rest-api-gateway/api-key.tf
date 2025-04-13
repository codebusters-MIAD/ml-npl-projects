resource "aws_api_gateway_api_key" "api_gateway_api_key" {
  name = var.api_gateway_api_key_name
  tags = local.tags
}

resource "aws_api_gateway_usage_plan" "api_gateway_usage_plan" {
  name        = var.api_gateway_usage_plan_name
  description = var.api_gateway_usage_plan_description

  api_stages {
    api_id = aws_api_gateway_rest_api.api_gateway_rest_api.id
    stage  = aws_api_gateway_stage.api_gateway_stage.stage_name
  }

  throttle_settings {
    burst_limit = var.usage_plan_burst_limit
    rate_limit  = var.usage_plan_rate_limit
  }
  tags = local.tags
}
resource "aws_api_gateway_usage_plan_key" "api_gateway_usage_plan_key" {
  key_id        = aws_api_gateway_api_key.api_gateway_api_key.id
  key_type      = var.api_gateway_usage_plan_key_type
  usage_plan_id = aws_api_gateway_usage_plan.api_gateway_usage_plan.id
}