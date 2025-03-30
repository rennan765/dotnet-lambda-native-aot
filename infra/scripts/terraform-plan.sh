#!/bin/bash
set -e  # Script fails if has error

cd infra

terraform fmt
terraform init
terraform validate
terraform plan -var='dotnet_environment=Development'

cd ..