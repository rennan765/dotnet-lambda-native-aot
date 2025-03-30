#!/bin/bash
set -e  # Script fails if has error

chmod +x app/publish-native-aot.sh \
    infra/scripts/variables/commons.sh \
    infra/scripts/variables/development.sh \
    infra/scripts/helpers/verify-exec-on-s3.sh

source infra/scripts/variables/commons.sh
source infra/scripts/variables/development.sh
source infra/scripts/helpers/verify-exec-on-s3.sh