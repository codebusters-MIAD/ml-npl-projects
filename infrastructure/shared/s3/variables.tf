#-----------------------------------------------------------------------------------------------------------------------
# (MANDATORY) - INPUT VARIABLES - S3
#-----------------------------------------------------------------------------------------------------------------------
# Common variables:
variable "environment" { type = string }
# Tags
variable "tags" { type = object({ BudgetId = string, Project = string}) }

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}
#-----------------------------------------------------------------------------------------------------------------------
# (OPTIONAL) - INPUT VARIABLES - S3
#-----------------------------------------------------------------------------------------------------------------------
variable "enable_versioning" {
  type        = bool
  default     = false
  description = "Enable versioning for the S3 bucket"
}

variable "force_destroy" {
  type        = bool
  default     = false
}
