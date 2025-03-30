provider "aws" {
  region = "sa-east-1" 
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

# IAM
data "aws_iam_policy" "default_lambda_policy" {
  name = "DefaultLambdaPolicy"
}