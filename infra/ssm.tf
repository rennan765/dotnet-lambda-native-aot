## Bucket S3
# Deploy Lambda Function
resource "aws_ssm_parameter" "deploy_lambda_functions" {
  name        = "/rennan765/deploy_lambda_functions/bucket_name"
  description = "Bucket name for zip files and other executables used to deploy Lambda functions."
  type        = "String"
  value       = aws_s3_bucket.deploy_lambda_functions.id

  tags = {
    Environment = var.dotnet_environment
  }
}

# Terraform Deployments
resource "aws_ssm_parameter" "terraform_deployments" {
  name        = "/rennan765/terraform_deployments/bucket_name"
  description = "Bucket name for apps' terraform's tsfars files"
  type        = "String"
  value       = aws_s3_bucket.terraform_deployments.id

  tags = {
    Environment = var.dotnet_environment
  }
}

resource "aws_ssm_parameter" "terraform_deployments_maintain_user_data" {
  name        = "/rennan765/terraform_deployments/maintain_user_data"
  description = "Folder for maintain-user-data function's tfstate files"
  type        = "String"
  value       = local.app_identification

  tags = {
    Environment = var.dotnet_environment
  }
}
