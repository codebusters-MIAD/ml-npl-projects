locals {
  cw_log_group_path_name = "${var.cw_log_group_lambda}${aws_lambda_function.lambda_function.function_name}"
  cw_log_group_name      = "${aws_lambda_function.lambda_function.function_name}-cw-log-group"
}

resource "aws_cloudwatch_log_group" "cw_log_group_lambda" {
  name              = local.cw_log_group_path_name
  retention_in_days = var.cw_log_group_retention_days
  tags = {
    Name     = local.cw_log_group_name
    Project  = var.tags.Project
    BudgetId = var.tags.BudgetId
    Env      = var.environment
  }
}
