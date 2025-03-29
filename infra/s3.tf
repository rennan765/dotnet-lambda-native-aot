# Deploy Lambda Functions
resource "aws_s3_bucket" "deploy_lambda_functions" {
  bucket = var.deploy_function_bucket_name
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
        Action    = [
          "s3:PutObject",
          "s3:GetObject"
        ],
        Resource  = "${aws_s3_bucket.deploy_lambda_functions.arn}/*",
        Condition = {
          StringEquals = {
            "aws:PrincipalArn": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/*"
          }
        }
      },
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = [
          "s3:ListBucket"
        ],
        Resource  = "${aws_s3_bucket.deploy_lambda_functions.arn}",
        Condition = {
          StringEquals = {
            "aws:PrincipalArn": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/*"
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

# Terraform deployments
resource "aws_s3_bucket" "terraform_deployments" {
  bucket = var.terraform_deployments_bucket_name
}

resource "aws_s3_bucket_public_access_block" "terraform_deployments" {
  bucket                  = aws_s3_bucket.terraform_deployments.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "terraform_deployments_policy" {
  bucket = aws_s3_bucket.terraform_deployments.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = [
          "s3:PutObject",
          "s3:GetObject"
        ],
        Resource  = "${aws_s3_bucket.terraform_deployments.arn}/*",
        Condition = {
          StringEquals = {
            "aws:SourceAccount": data.aws_caller_identity.current.account_id
          }
        }
      },
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = [
          "s3:ListBucket"
        ],
        Resource  = "${aws_s3_bucket.terraform_deployments.arn}",
        Condition = {
          StringEquals = {
            "aws:SourceAccount": data.aws_caller_identity.current.account_id
          }
        }
      }
    ]
  })
}