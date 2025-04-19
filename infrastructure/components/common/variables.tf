variable "aws_app_tags" {
  type = object({
    BudgetId = string, Project = string
  })
  default = {
    BudgetId = "ML-NPL"
    Project  = "spotify-class-model"
  }
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "Force destroy the bucket and its contents when destroying infrastructure"
}

variable "bucket_name" {
  type        = string
  description = "common-onnx-models-bucket"
  default     = "common-onnx-models-bucket"
}

variable "policy_name" {
  type    = string
  default = "upload-onnx-to-s3-folder-policy"
}
