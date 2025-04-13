#=======================================================================================================================
# LAMBDA MODULE
#=======================================================================================================================
locals {
  ecr_repo = "${var.tag_name}-repo"
  lambda_name = "${var.tag_name}-lambda"
}

resource "aws_lambda_function" "lambda_function" {

  function_name = var.tag_name
  description   = var.lambda_description
  role          = var.lambda_iam_role_arn
  timeout       = var.lambda_timeout
  image_uri     = "${aws_ecr_repository.ecr_repo.repository_url}@${data.aws_ecr_image.lambda_image.id}"
  package_type  = var.lambda_package_type
  memory_size   = var.memory_size

  ephemeral_storage {
    size = var.ephemeral_storage_size
  }

  environment {
    variables = {
      APP_ENV = var.container_path_env
    }
  }

  tags = {
    Name     = local.lambda_name
    Project  = var.tags.Project
    BudgetId = var.tags.BudgetId
    Env      = var.environment
  }
}

