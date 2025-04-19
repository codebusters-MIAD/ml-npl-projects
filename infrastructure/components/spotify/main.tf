#-----------------------------------------------------------------------------------------------------------------------
#                                           ..::Project 1 - Resources::..
#-----------------------------------------------------------------------------------------------------------------------
# Common components: Lambda to call model pre train about spotify
#=======================================================================================================================
locals {
  lambda_name = "${var.aws_app_tags.Project}-function"
}

# Storage to persist the model
resource "aws_s3_object" "s3_onnx_models" {
  bucket  = data.aws_s3_bucket.s3.id
  key     = var.model_bucket_object
  content = ""  # Empty content to simulate a folder
}

# Lambda permission
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

# Create an API Gateway to enable the model spotify service
module "spotify_api_gateway" {
  source               = "../../shared/api-gateway2"
  lambda_function_arn  = module.aws_lambda_spotify_class_model.arn
  lambda_function_name = module.aws_lambda_spotify_class_model.function_name
  api_name             = "spotify-api"
  route_key            = "POST /predict"
  stage_name           = "DEV"
  aws_app_tags         = var.aws_app_tags
  environment          = var.environment
  tags                 = var.aws_app_tags
}
