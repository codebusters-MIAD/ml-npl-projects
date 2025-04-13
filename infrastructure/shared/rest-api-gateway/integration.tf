// POST Method
resource "aws_api_gateway_integration" "api_gateway_integration" {
  http_method             = aws_api_gateway_method.api_gateway_method.http_method
  resource_id             = aws_api_gateway_resource.aws_api_gateway_resource.id
  rest_api_id             = aws_api_gateway_rest_api.api_gateway_rest_api.id
  integration_http_method = var.api_gateway_http_integration_method
  type                    = var.api_gateway_http_integration_type
  uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.lambda_function_arn}/invocations"
  content_handling        = var.convert_to_text
}

// DELETE Method
# resource "aws_api_gateway_integration" "api_gateway_integration_del" {
#   http_method             = aws_api_gateway_method.api_gateway_method_del.http_method
#   resource_id             = aws_api_gateway_resource.aws_api_gateway_resource.id
#   rest_api_id             = aws_api_gateway_rest_api.api_gateway_rest_api.id
#   integration_http_method = var.api_gateway_http_integration_method
#   type                    = var.api_gateway_http_integration_type
#   uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.lambda_function_arn}/invocations"
#   content_handling        = var.convert_to_text
# }