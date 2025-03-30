#!/bin/bash
set -e  # Script fails if has error

echo 'Preparing environment for tests...'

cd app/test

echo 'Setting env vars...'
export CONNECTION_STRING="Server=localhost;Database=aot_tests;User Id=root;Password=default123;"
export AWS_REGION='sa-east-1'
export AWS_PROFILE='default'
export AWS_LAMBDA_RUNTIME_API='localhost:5050'

echo 'Running docker-compose...'
docker-compose up -d

echo 'Waiting containers to start...'
sleep 30

echo 'Environment ready to use.'
