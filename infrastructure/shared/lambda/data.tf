//Identity
data "aws_caller_identity" "current" {}

//ECR
data "aws_ecr_image" "lambda_image" {
  repository_name = local.ecr_repo
  image_tag       = var.ecr_image_tag

  depends_on = [
    null_resource.ecr_image
  ]
}