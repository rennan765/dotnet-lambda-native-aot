resource "aws_s3_bucket" "deploy_lambda_functions" {
  bucket = local.deploy_function_bucket_name
}

resource "aws_s3_bucket_public_access_block" "deploy_lambda_functions" {
  bucket                  = aws_s3_bucket.deploy_lambda_functions.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "deploy_lambda_functions_policy" {
  bucket = aws_s3_bucket.deploy_lambda_functions.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:PutObject",
        Resource  = "${aws_s3_bucket.deploy_lambda_functions.arn}/*",
        Condition = {
          StringEquals = {
            "aws:PrincipalArn": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_lifecycle_configuration" "deploy_lambda_functions_lifecycle" {
  bucket = aws_s3_bucket.deploy_lambda_functions.id

  rule {
    id     = "delete-after-1-day"
    status = "Enabled"

    filter {
      prefix = "" 
    }

    expiration {
      days = 1
    }
  }
}
