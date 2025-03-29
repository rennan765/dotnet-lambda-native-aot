#!/bin/bash
set -e  # Script fails if has error

echo 'Getting tstate files...'

tfstate_file_name=terraform.tfstate
tfstate_backup_file_name=terraform.tfstate.backup

is_tfstate_file_exists=$(aws s3 cp "s3://$TERRAFORM_DEPLOYMENTS_BUCKET_NAME/$APP_IDENTIFICATION/$tfstate_file_name" infra/ > /dev/null 2>&1 && echo "true" || echo "false")
if [ $is_tfstate_file_exists = "true" ]; then
    echo "$tfstate_file_name found."
else
    echo "$tfstate_file_name not found. It will be generated and saved at $TERRAFORM_DEPLOYMENTS_BUCKET_NAME/$APP_IDENTIFICATION."
fi

is_tfstate_backup_file_exists=$(aws s3 cp "s3://$TERRAFORM_DEPLOYMENTS_BUCKET_NAME/$APP_IDENTIFICATION/$tfstate_backup_file_name" infra/ > /dev/null 2>&1 && echo "true" || echo "false")
if [ $is_tfstate_backup_file_exists = "true" ]; then
    echo "$tfstate_backup_file_name found."
else
    echo "$tfstate_backup_file_name not found. It will be generated and saved at $TERRAFORM_DEPLOYMENTS_BUCKET_NAME/$APP_IDENTIFICATION."
fi
