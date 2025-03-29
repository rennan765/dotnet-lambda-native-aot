#!/bin/bash
set -e  # Script fails if has error

echo 'Getting env vars from Parameter Store...'

export APP_IDENTIFICATION=$(aws ssm get-parameter --name //rennan765\\terraform_deployments\\maintain_user_data --region sa-east-1 --query "Parameter.Value" --output text)
export FUNCTION_FILENAME="$APP_IDENTIFICATION.zip"
export DEPLOY_FUNCTION_BUCKET_NAME=$(aws ssm get-parameter --name //rennan765\\deploy_lambda_functions\\bucket_name --region sa-east-1 --query "Parameter.Value" --output text)
export TERRAFORM_DEPLOYMENTS_BUCKET_NAME=$(aws ssm get-parameter --name //rennan765\\terraform_deployments\\bucket_name --region sa-east-1 --query "Parameter.Value" --output text)