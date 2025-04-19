#-----------------------------------------------------------------------------------------------------------------------
# (MANDATORY) - INPUT VARIABLES - LAMBDA
#-----------------------------------------------------------------------------------------------------------------------
# Common variables:
variable "environment" { type = string }
variable "tags" { type = object({ BudgetId = string, Project = string}) }

variable "api_name" {
  type = string
}

variable "lambda_function_arn" {
  type = string
}

variable "lambda_function_name" {
  type = string
}

variable "route_key" {
  type = string
}

variable "stage_name" {
  type = string
}

variable "aws_app_tags" {
  type = map(string)
}

#-----------------------------------------------------------------------------------------------------------------------
# (OPTIONAL) - INPUT VARIABLES - API GATEWAY 2
#-----------------------------------------------------------------------------------------------------------------------
