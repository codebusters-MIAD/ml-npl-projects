#-----------------------------------------------------------------------------------------------------------------------
# (MANDATORY) - INPUT VARIABLES - LAMBDA
#-----------------------------------------------------------------------------------------------------------------------
# Common variables:
variable "environment" { type = string }
variable "aws_region" { type = string }

# Lambda resource
variable "lambda_description" { type = string }
variable "container_path_env" { type = string }

# IAM Role
variable "lambda_iam_role_arn" { type = string }

# Tags
variable "tag_name" { type = string }
variable "tags" { type = object({ BudgetId = string, Project = string}) }

#=======================================================================================================================
# (OPTIONAL) - INPUT VARIABLES - LAMBDA
#=======================================================================================================================
# ECR
variable "enabled_local_docker_builder" {
  type = bool
  default = true
}

variable "trigger_path" {
  type = string
  default = "Not defined"
}

variable "trigger_script_file" {
  type = string
  default = "Not defined"
}

# Lambda
variable "lambda_package_type" {
  type    = string
  default = "Image"
}

variable "lambda_timeout" {
  type    = number
  default = 900
}

variable "memory_size" {
  type = number
  default = 128
}

variable "ephemeral_storage_size" {
  type = number
  default = 512
}

# ECR
variable "ecr_image_tag" {
  type    = string
  default = "latest"
}

# Cloud watch
variable "cw_log_group_retention_days" {
  type    = number
  default = 14
}

# Monitoring
variable "cw_log_group_lambda" {
  type    = string
  default = "/aws/lambda/"
}

variable "force_delete" {
  default = false
  type = bool
}