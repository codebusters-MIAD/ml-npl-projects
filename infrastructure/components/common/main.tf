#-----------------------------------------------------------------------------------------------------------------------
#                                           ..::Common - Resources::..
#-----------------------------------------------------------------------------------------------------------------------
# Common components
#=======================================================================================================================
# Create a S3 to storage the ONNX binary
module "onnx_s3_bucket" {
  source            = "../../shared/s3"
  bucket_name       = var.bucket_name
  enable_versioning = true
  force_destroy     = true
  tags              = var.aws_app_tags
  environment       = var.environment
}


resource "aws_iam_policy" "upload_onnx_policy" {
  name        = var.policy_name
  description = "Permite subir archivos .onnx al prefijo models/ en el bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowUploadToModelsPrefix",
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl"
        ],
        Resource = "arn:aws:s3:::${var.bucket_name}/models/*"
      }
    ]
  })
  tags = var.aws_app_tags
}
