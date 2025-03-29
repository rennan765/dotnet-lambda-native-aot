#!/bin/bash
set -e  # Script fails if has error

echo 'Verifying exec file...'

is_file_exists=$(aws s3api head-object --bucket $DEPLOY_FUNCTION_BUCKET_NAME --key $FUNCTION_FILENAME > /dev/null 2>&1 && echo "true" || echo "false")

if [ $is_file_exists = "false" ]; then
    echo "Exec file not found. Publishing again..."

    sh app/publish-native-aot.sh
    aws s3 mv "app/$FUNCTION_FILENAME" s3://$DEPLOY_FUNCTION_BUCKET_NAME/

    echo "Publish succeeded, zipped and saved at $DEPLOY_FUNCTION_BUCKET_NAME"
fi