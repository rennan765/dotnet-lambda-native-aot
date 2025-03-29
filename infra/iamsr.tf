resource "aws_iam_policy" "execute_maintain_user_data_policy" {
  name        = "execute-maintain-user-data-policy"
  path        = "/"
  description = "Policy to execute maintain-user-data Lambda Function"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "SQS",
        Effect = "Allow",
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage"
        ],
        Resource = [
          aws_sqs_queue.user_data_received.arn,
          aws_sqs_queue.user_data_received_dlq.arn
        ]
      },
      {
        Sid = "SecretsManager",
        Effect = "Allow",
        Action = "secretsmanager:GetSecretValue",
        Resource = "arn:aws:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:*"
      }
    ]
  })
}

resource "aws_iam_role" "execute_maintain_user_data_role" {
  name = "execute-maintain-user-data-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = { "Service": "lambda.amazonaws.com" },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "execute_maintain_user_data_policy_attach" {
  role       = aws_iam_role.execute_maintain_user_data_role.name
  policy_arn = aws_iam_policy.execute_maintain_user_data_policy.arn
}

resource "aws_iam_role_policy_attachment" "default_lambda_policy_attach" {
  role       = aws_iam_role.execute_maintain_user_data_role.name
  policy_arn = data.aws_iam_policy.default_lambda_policy.arn
}