#=======================================================================================================================
# Common
#=======================================================================================================================
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "container_path_env" {
  type    = string
  default = "./resources/app_env/dev.ini"
}

#=======================================================================================================================
# AWS BUDGET TAGS
#=======================================================================================================================
variable "aws_app_tags" {
  type    = object({
    BudgetId = string, Project = string
  })
  default = {
    BudgetId = "ML-NPL"
    Project  = "spotify-class-model"
  }
}

#=======================================================================================================================
# LAMBDAS
#=======================================================================================================================
#Common
variable "assume_role_policy_lambda" {
  type    = string
  default = <<EOF
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Action":"sts:AssumeRole",
         "Principal":{
            "Service":"lambda.amazonaws.com"
         },
         "Effect":"Allow",
         "Sid":""
      }
   ]
}
EOF
}

#=======================================================================================================================
# Performance test
#=======================================================================================================================
variable "lambda_name" {
  type    = string
  default = "spotify-lambda-function"
}

variable "lambda_description" {
  default = "This lambda permits to run a classification model about spotify"
}

variable "lambda_script_file" {
  type    = string
  default = "src/app/app.py"
}

variable "lambda_trigger_path" {
  type    = string
  default = "/../../../projects/spotify-model/"
}

variable "lambda_trigger_script_file" {
  type    = string
  default = "src/app/model_service.py"
}

variable "lambda_arn_policies" {
  type    = map(object({
    arn = string
  }))
  default = {
    AWSLambdaBasicExecutionRole     = {
      arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
    }
  }
}

variable "lambda_iam_role" {
  default = "spotify_lambda_model_role"
}

variable "lambda_memory_size" {
  default = 512
}

variable "lambda_storage_size" {
  type = number
  default = 512
}

#=======================================================================================================================
# NETWORK - Common variables
#=======================================================================================================================

#=======================================================================================================================
# API Gateway
#=======================================================================================================================
variable "domain" {
  type    = string
  default = "dc68032.easn.morningstar.com"
}

# variable "route53_s3_perf_test_subdomain" {
#   default = "api"
# }
#
# variable "perf_test_api_gw_resource_path" {
#   default = "at-auto-xpath-ops"
# }
#
# variable "api_gateway_perf_test_api_key_name" {
#   default = "api-key-at-perf-test"
# }
#
# variable "api_gateway_perf_test_usage_plan_name" {
#   default = "usage-plan-at-perf-test"
# }
#
# variable "api_gateway_perf_test_usage_plan_description" {
#   default = "Usage plan for At performance test lambda"
# }
#
# variable "perf_test_api_gw_name" {
#   default = "perf-test-ui-integration"
# }
# variable "ssl_certificate_arn" {
#   type    = string
#   default = "arn:aws:acm:us-east-1:179020893316:certificate/251ed29b-7284-4f28-8197-b220819be5db"
# }

