chmod +x app/publish-native-aot.sh \
    infra/scripts/variables/commons.sh \
    infra/scripts/variables/development.sh \
    infra/scripts/helpers/verify-exec-on-s3.sh

cd infra/scripts/

source variables/commons.sh
source variables/development.sh
source helpers/verify-exec-on-s3.sh