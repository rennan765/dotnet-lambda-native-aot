#!/bin/bash
set -e  # Script fails if has error

export RID=$(dotnet --info | grep "RID" | awk '{print $2}')
echo "Current runtime: $RID"

# Navigate to folder
cd app/src/MaintainUserData

echo 'Restoring dependencies...'
dotnet restore -r $RID

echo 'Building...'
dotnet build --configuration Release --no-restore -r $RID

echo 'Publishing...'
dotnet publish --configuration Release --no-restore -r $RID --self-contained true -o ./publish

echo 'Publish succeeded. Zipping files...'
cd publish
zip -r MaintainUserData.zip *
cd ..
cd ..
cd ..
cd .. 
sudo mv app/src/MaintainUserData/publish/MaintainUserData.zip app/MaintainUserData.zip

echo 'Success'