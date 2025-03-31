#!/bin/bash
set -e  # Script fails if has error

echo "Installing dependencies..."
yum install -y gcc glibc glibc-devel dotnet-sdk-8.0 tar gzip zlib-devel
echo "Finished"