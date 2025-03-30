#!/bin/bash
set -e  # Script fails if has error

echo 'Uploading tstate files...'

tfstate_file_name=terraform.tfstate
tfstate_backup_file_name=terraform.tfstate.backup

aws s3 mv "infra/$tfstate_file_name" s3://$TERRAFORM_DEPLOYMENTS_BUCKET_NAME/$APP_IDENTIFICATION/
aws s3 mv "infra/$tfstate_backup_file_name" s3://$TERRAFORM_DEPLOYMENTS_BUCKET_NAME/$APP_IDENTIFICATION/

echo "Tfstate files moved to $TERRAFORM_DEPLOYMENTS_BUCKET_NAME." 