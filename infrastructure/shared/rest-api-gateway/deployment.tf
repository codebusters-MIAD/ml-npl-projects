resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_rest_api.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.aws_api_gateway_resource.id,
      aws_api_gateway_method.api_gateway_method.id,
      aws_api_gateway_integration.api_gateway_integration.id,
      aws_api_gateway_method.api_gateway_method_del.id,
      aws_api_gateway_integration.api_gateway_integration_del.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}