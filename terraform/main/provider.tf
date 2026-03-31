
terraform {
  required_version = ">= 1.3"

  backend "s3" {
    bucket         = "dn-cvs-challenge-tf-state-bucket" # S3 bucket created in bootstrap
    key            = "main/terraform.tfstate"           # path to state file inside bucket
    region         = "us-west-2"                        # same AWS region
    dynamodb_table = "terraform-locks"                  # lock table from bootstrap
    encrypt        = true                               # encrypt state at rest
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2" # deployment region
}
