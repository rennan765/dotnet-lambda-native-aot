resource "aws_lambda_function" "maintain_user_data" {
  function_name   = local.function_name
  role            = aws_iam_role.execute_maintain_user_data_role.arn
  handler         = local.function_handler
  runtime         = "dotnet8"

  s3_bucket = local.deploy_function_bucket_name
  s3_key    = local.function_filename

  environment {
    variables = {
      DOTNET_ENVIRONMENT = var.dotnet_environment,
      AWS_REGION = data.aws_region.current.name
      CONNECTION_STRING = aws_secretsmanager_secret_version.user_data_connection_string.secret_string
    }
  }

  depends_on = [aws_s3_bucket.deploy_lambda_functions]
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = aws_sqs_queue.user_data_received.arn
  function_name    = aws_lambda_function.maintain_user_data.arn
  enabled          = true
  batch_size       = 15 
}