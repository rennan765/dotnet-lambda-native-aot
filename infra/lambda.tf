resource "aws_lambda_function" "maintain_user_data" {
  function_name = local.function_name
  role          = aws_iam_role.execute_maintain_user_data_role.arn
  handler       = local.function_handler
  runtime       = local.function_runtime

  s3_bucket = var.deploy_function_bucket_name
  s3_key    = var.function_filename

  publish = true

  environment {
    variables = {
      DOTNET_ENVIRONMENT = var.dotnet_environment,
      REGION             = data.aws_region.current.name
      CONNECTION_STRING  = data.aws_secretsmanager_secret_version.db_test_secret_version.secret_string
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  timeout     = local.function_timeout
  memory_size = local.function_memory_size

  vpc_config {
    security_group_ids = [data.aws_security_group.default.id]
    subnet_ids         = var.subnet_ids
  }

  depends_on = [
    aws_s3_bucket.deploy_lambda_functions,
    aws_ssm_parameter.deploy_lambda_functions
  ]
}

resource "aws_lambda_alias" "maintain_user_data_latest" {
  name             = local.function_alias
  function_name    = aws_lambda_function.maintain_user_data.arn
  function_version = aws_lambda_function.maintain_user_data.version
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = aws_sqs_queue.user_data_received.arn
  function_name    = aws_lambda_alias.maintain_user_data_latest.arn
  enabled          = true

  batch_size                         = 15
  maximum_batching_window_in_seconds = 10
}
