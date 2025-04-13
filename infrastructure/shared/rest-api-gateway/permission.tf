resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = var.lambda_permissions_statement_id
  action        = var.lambda_permissions_action
  function_name = var.lambda_function_name
  principal     = var.lambda_permissions_principal

  source_arn = "${aws_api_gateway_rest_api.api_gateway_rest_api.execution_arn}/*/*"
}