terraform {
  backend "s3" {
    bucket = "ml-npl-terraform"
    key    = "terraform/terraform-proj-spotify.tfstate"
    region = "us-east-1"
  }
  required_version = ">= 1.11.4"

  required_providers {
     aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
