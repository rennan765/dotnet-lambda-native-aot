locals {
  sqs_queue_name = "user-data-received"
  sqs_dlq_name   = "user-data-received-dlq"

  app_identification = "MaintainUserData"

  function_name        = "maintain-user-data"
  function_runtime     = "dotnet8"
  function_handler     = local.app_identification
  function_alias       = "latest"
  function_timeout     = 30
  function_memory_size = 128
}