provider "aws" {
  region = "sa-east-1"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

# IAM
data "aws_iam_policy" "default_lambda_policy" {
  name = "DefaultLambdaPolicy"
}

# Secrets Manager
data "aws_secretsmanager_secret" "db_test_secret" {
  name = "db-test-connection-string"
}

data "aws_secretsmanager_secret_version" "db_test_secret_version" {
  secret_id = data.aws_secretsmanager_secret.db_test_secret.id
}