#!/bin/bash
set -e  # Script fails if has error

chmod +x app/publish-native-aot.sh \
    infra/scripts/variables/development.sh \
    infra/scripts/variables/commons.sh \
    infra/scripts/helpers/get-tstate-files.sh \
    infra/scripts/helpers/verify-exec-on-s3.sh \
    infra/scripts/helpers/upload-tstate-files.sh

. infra/scripts/variables/development.sh
. infra/scripts/variables/commons.sh
. infra/scripts/helpers/get-tstate-files.sh
. infra/scripts/helpers/verify-exec-on-s3.sh

cd infra
terraform init
terraform validate

terraform plan -out deploy_from_sh \
    -var="dotnet_environment=$DOTNET_ENVIRONMENT" \
    -var="subnet_ids=$SUBNET_IDS" \
    -var="app_identification=$APP_IDENTIFICATION" \
    -var="function_filename=$FUNCTION_FILENAME" \
    -var="deploy_function_bucket_name=$DEPLOY_FUNCTION_BUCKET_NAME" \
    -var="terraform_deployments_bucket_name=$TERRAFORM_DEPLOYMENTS_BUCKET_NAME"

terraform apply deploy_from_sh

cd ..

sh infra/scripts/helpers/upload-tstate-files.sh