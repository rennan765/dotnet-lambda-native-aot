#!/bin/bash
set -e  # Script fails if has error

export DOTNET_ENVIRONMENT=Development
echo "DOTNET_ENVIRONMENT: $DOTNET_ENVIRONMENT"

export SUBNET_IDS="[\"subnet-0e1a9548125400468\",\"subnet-0639895ed32ef0794\",\"subnet-07d54d8a0c85dd7ac\"]"
echo "SUBNET_IDS: $SUBNET_IDS"