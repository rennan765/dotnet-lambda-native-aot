#!/bin/bash
set -e  # Script fails if has error

chmod +x infra/scripts/variables/development.sh \
    infra/scripts/variables/commons.sh 

. infra/scripts/variables/development.sh
. infra/scripts/variables/commons.sh

echo "Downloading exec. file..."
aws s3 cp s3://$DEPLOY_FUNCTION_BUCKET_NAME/$FUNCTION_FILENAME $FUNCTION_FILENAME 

echo "Updating Lambda Function with new exec. file..."
aws lambda update-function-code \
  --function-name $FUNCTION_NAME \
  --zip-file fileb://$FUNCTION_FILENAME

sleep 30

echo "Creating a Lambda Function's new version..."
NEW_VERSION=$(aws lambda publish-version --function-name $FUNCTION_NAME --query 'Version' --output text)

echo "New version created successfully: $NEW_VERSION"

echo "Udating alias $ALIAS_NAME to version $NEW_VERSION..."
aws lambda update-alias \
  --function-name $FUNCTION_NAME \
  --name $ALIAS_NAME \
  --function-version $NEW_VERSION

echo "Alias '$ALIAS_NAME' updated to version $NEW_VERSION successfully."

echo "Removing exec. file from S3..." 
aws s3 rm s3://$DEPLOY_FUNCTION_BUCKET_NAME/$FUNCTION_FILENAME

echo "Finished."