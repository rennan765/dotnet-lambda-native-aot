#!/bin/bash
set -e  # Script fails if has error

# Navigate to folder
cd src/MaintainUserData

echo 'Restoring dependencies...'
dotnet restore --use-current-runtime

echo 'Building...'
dotnet build --configuration Release --no-restore --use-current-runtime

echo 'Publishing...'
dotnet publish --configuration Release --no-restore --use-current-runtime --self-contained true -o ./publish

echo 'Publish succeeded. Showing publish folder content:'
cd publish
ls -l