#-----------------------------------------------------------------------------------------------------------------------
#                                           ..::Project 1 - Resources::..
#-----------------------------------------------------------------------------------------------------------------------
# The components

# Lambda to notify by email the cloudwatch alarms
#=======================================================================================================================
# LAMBDAS
#=======================================================================================================================
# Lambda to call a selenium project to make performance test through API Rest.
#-----------------------------------------------------------------------------------------------------------------------
locals {
  lambda_name = "${var.aws_app_tags.Project}-function"
}

module "aws_iam_spotify_class_model_profile" {
  source      = "../../shared/iam-role-attachment"
  environment = var.environment

  iam_role           = var.lambda_iam_role
  assume_role_policy = var.assume_role_policy_lambda
  arn_policies       = var.lambda_arn_policies

  is_required_profile = false

  tags = var.aws_app_tags
}

# lambda module
module "aws_lambda_spotify_class_model" {
  source      = "../../shared/lambda"
  environment = var.environment
  aws_region  = var.aws_region

  lambda_description     = var.lambda_description
  lambda_iam_role_arn    = module.aws_iam_spotify_class_model_profile.iam_role_arn_value
  memory_size            = var.lambda_memory_size
  ephemeral_storage_size = var.lambda_storage_size
  container_path_env     = var.container_path_env

  trigger_path        = var.lambda_trigger_path
  trigger_script_file = var.lambda_trigger_script_file

  tag_name = local.lambda_name
  tags     = var.aws_app_tags
}

resource "aws_apigatewayv2_api" "spotify_http_api" {
  name          = "spotify-api"
  protocol_type = "HTTP"
  tags          = var.aws_app_tags
}

resource "aws_apigatewayv2_integration" "spotify_lambda_integration" {
  api_id                 = aws_apigatewayv2_api.spotify_http_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = module.aws_lambda_spotify_class_model.arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "spotify_predict_route" {
  api_id    = aws_apigatewayv2_api.spotify_http_api.id
  route_key = "POST /predict"
  target    = "integrations/${aws_apigatewayv2_integration.spotify_lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.spotify_http_api.id
  name        = "$default"
  auto_deploy = true
  tags        = var.aws_app_tags
}

resource "aws_lambda_permission" "allow_api_gateway_invoke_lambda" {
  statement_id  = "AllowAPIGatewayInvokeSpotify"
  action        = "lambda:InvokeFunction"
  function_name = module.aws_lambda_spotify_class_model.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.spotify_http_api.execution_arn}/*/*"
}
