#-----------------------------------------------------------------------------------------------------------------------
# (MANDATORY) - INPUT VARIABLES - LAMBDA
#-----------------------------------------------------------------------------------------------------------------------
# Common variables:
variable "environment" { type = string }

variable "arn_policies" { type = map(object({ arn = string })) }
variable "assume_role_policy" { type = string }
variable "iam_role" { type = string }

# Tags
variable "tags" { type = object({ Project = string, BudgetId = string}) }

#=======================================================================================================================
# (OPTIONAL) - INPUT VARIABLES - LAMBDA
#=======================================================================================================================
variable "is_required_profile" {
  type    = bool
  default = true
}

variable "profile_name" {
  type    = string
  default = ""
}
