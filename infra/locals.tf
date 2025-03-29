locals {
    sqs_queue_name  = "user-data-received"
    sqs_dlq_name    = "user-data-received-dlq"

    deploy_function_bucket_name = "deploy-lambda-functions"

    function_name       = "maintain-user-data"
    function_runtime    = "dotnet8"
    function_handler    = "MaintainUserData"
    function_filename   = "./publish/MaintainUserData.zip"
}