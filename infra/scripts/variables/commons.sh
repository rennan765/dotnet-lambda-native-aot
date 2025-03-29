#!/bin/bash
set -e  # Script fails if has error

echo 'Getting env vars from Parameter Store...'

app_id_parameter_name="//rennan765\\terraform_deployments\\maintain_user_data"
deploy_function_bucket_name_parameter_name="//rennan765\\deploy_lambda_functions\\bucket_name"
terraform_deployments_bucket_name_parameter_name="//rennan765\\terraform_deployments\\bucket_name"

if uname | grep -q "Linux"; then
    app_id_parameter_name="/rennan765/terraform_deployments/maintain_user_data"
    deploy_function_bucket_name_parameter_name="/rennan765/deploy_lambda_functions/bucket_name"
    terraform_deployments_bucket_name_parameter_name="/rennan765/terraform_deployments/bucket_name"
fi

export APP_IDENTIFICATION=$(aws ssm get-parameter --name $app_id_parameter_name --region sa-east-1 --query "Parameter.Value" --output text)
export FUNCTION_FILENAME="$APP_IDENTIFICATION.zip"
export DEPLOY_FUNCTION_BUCKET_NAME=$(aws ssm get-parameter --name $deploy_function_bucket_name_parameter_name --region sa-east-1 --query "Parameter.Value" --output text)
export TERRAFORM_DEPLOYMENTS_BUCKET_NAME=$(aws ssm get-parameter --name $terraform_deployments_bucket_name_parameter_name --region sa-east-1 --query "Parameter.Value" --output text)