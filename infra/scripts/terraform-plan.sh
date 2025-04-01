#!/bin/bash
set -e  # Script fails if has error

chmod +x infra/scripts/variables/commons.sh \
    infra/scripts/variables/development.sh

. infra/scripts/variables/development.sh
. infra/scripts/variables/commons.sh

cd infra

terraform fmt
terraform init
terraform validate

terraform plan \
    -var="dotnet_environment=$DOTNET_ENVIRONMENT" \
    -var="subnet_ids=$SUBNET_IDS"

cd ..