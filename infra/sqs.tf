resource "aws_sqs_queue" "user_data_received_dlq" {
  name                      = local.sqs_dlq_name
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "user_data_received" {
  name                      = local.sqs_queue_name
  message_retention_seconds = 345600 # 4 dias
  redrive_policy            = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.user_data_received_dlq.arn
    maxReceiveCount     = 5
  })
}

resource "aws_sqs_queue_policy" "user_data_received_policy" {
  queue_url = aws_sqs_queue.user_data_received.id
  policy    = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { "Service": "lambda.amazonaws.com" },
      Action    = "sqs:SendMessage",
      Resource  = aws_sqs_queue.user_data_received.arn
    }]
  })
}