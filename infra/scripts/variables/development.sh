#!/bin/bash
set -e  # Script fails if has error

export DOTNET_ENVIRONMENT=Development
export APP_IDENTIFICATION='MaintainUserData'
export FUNCTION_FILENAME='MaintainUserData.zip'
export DEPLOY_FUNCTION_BUCKET_NAME='deploy-lambda-functions-rennan765'
export TERRAFORM_DEPLOYMENTS_BUCKET_NAME='terraform-deployments-rennan765'