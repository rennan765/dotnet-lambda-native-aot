#!/bin/bash
set -e  # Script fails if has error

chmod +x app/publish-native-aot.sh \
    infra/scripts/variables/commons.sh \
    infra/scripts/variables/development.sh \
    infra/scripts/helpers/verify-exec-on-s3.sh

. infra/scripts/variables/commons.sh
. infra/scripts/variables/development.sh
. infra/scripts/helpers/verify-exec-on-s3.sh