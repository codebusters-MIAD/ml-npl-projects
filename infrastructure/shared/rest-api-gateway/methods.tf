// POST Method
resource "aws_api_gateway_method" "api_gateway_method" {
  authorization    = var.api_gateway_method_auth
  api_key_required = var.api_key_required
  http_method      = var.api_gateway_http_post_method
  resource_id      = aws_api_gateway_resource.aws_api_gateway_resource.id
  rest_api_id      = aws_api_gateway_rest_api.api_gateway_rest_api.id
}

resource "aws_api_gateway_method_response" "method_response" {
  rest_api_id     = aws_api_gateway_rest_api.api_gateway_rest_api.id
  resource_id     = aws_api_gateway_resource.aws_api_gateway_resource.id
  http_method     = aws_api_gateway_method.api_gateway_method.http_method
  status_code     = var.method_response_code
  response_models = var.response_content_type
}

// DELETE Method
# resource "aws_api_gateway_method" "api_gateway_method_del" {
#   authorization    = var.api_gateway_method_auth
#   api_key_required = var.api_key_required
#   http_method      = var.api_gateway_http_delete_method
#   resource_id      = aws_api_gateway_resource.aws_api_gateway_resource.id
#   rest_api_id      = aws_api_gateway_rest_api.api_gateway_rest_api.id
# }
#
# resource "aws_api_gateway_method_response" "method_response_del" {
#   rest_api_id     = aws_api_gateway_rest_api.api_gateway_rest_api.id
#   resource_id     = aws_api_gateway_resource.aws_api_gateway_resource.id
#   http_method     = aws_api_gateway_method.api_gateway_method_del.http_method
#   status_code     = var.method_response_code
#   response_models = var.response_content_type
# }