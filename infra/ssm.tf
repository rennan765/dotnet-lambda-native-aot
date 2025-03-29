## Bucket S3
# Deploy Lambda Function
resource "aws_ssm_parameter" "deploy_lambda_functions" {
  name        = "/rennan765/deploy_lambda_functions/bucket_name" 
  description = "Database password for the application" 
  type        = "String" 
  value       = aws_s3_bucket.deploy_lambda_functions.id

  tags = {
    Environment = var.dotnet_environment
  }
}

# Terraform Deployments
resource "aws_ssm_parameter" "terraform_deployments" {
  name        = "/rennan765/terraform_deployments/bucket_name" 
  description = "Database password for the application" 
  type        = "String" 
  value       = aws_s3_bucket.deploy_lambda_functions.id

  tags = {
    Environment = var.dotnet_environment
  }
}

resource "aws_ssm_parameter" "terraform_deployments_maintain_user_data" {
  name        = "/rennan765/terraform_deployments/maintain_user_data" 
  description = "Database password for the application" 
  type        = "String" 
  value       = local.app_identification

  tags = {
    Environment = var.dotnet_environment
  }
}
