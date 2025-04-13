locals {
  path = "/${var.api_gateway_rest_api_resource_path}"
}

resource "aws_api_gateway_documentation_part" "post" {
  location {
    type   = var.method
    method = var.api_gateway_http_post_method
    path   = local.path
  }

  properties  = "{\"materia\":\"ML-NPL\"}"
  rest_api_id = aws_api_gateway_rest_api.api_gateway_rest_api.id
}

resource "aws_api_gateway_documentation_part" "delete" {
  location {
    type   = var.method
    method = var.api_gateway_http_delete_method
    path   = local.path
  }

  properties  = "{\"materia\":\"ML-NPL\"}"
  rest_api_id = aws_api_gateway_rest_api.api_gateway_rest_api.id
}