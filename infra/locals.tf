locals {
    sqs_queue_name  = "user-data-received"
    sqs_dlq_name    = "user-data-received-dlq"

    deploy_function_bucket_name         = "deploy-lambda-functions-rennan765"
    terraform_deployments_bucket_name   = "terraform-deployments-rennan765"

    app_identification = "MaintainUserData"

    function_filename   = "${local.app_identification}.zip"
    function_name       = "maintain-user-data"
    function_runtime    = "dotnet8"
    function_handler    = local.app_identification
}