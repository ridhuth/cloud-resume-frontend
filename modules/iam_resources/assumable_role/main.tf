
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.17.0"
      configuration_aliases = [ aws.global, aws.dev ]
    }
  }
}



### Global ACCOUNT ###

resource "aws_iam_role" "lock_dynamo_role" {
    name = "lock_dynamo_role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Sid    = ""
                Principal = {
                    AWS = "arn:aws:iam::${var.dev_account_id}:role/global_dynamo_role_default"
                }
            },
        ]
    })
    provider = aws.global
}

resource "aws_iam_policy" "global_dynamo" {
  name        = "terraform_lock_access"
  description = "allow terraform to lock state"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
            "dynamodb:DescribeTable",
            "dynamodb:GetItem",
            "dynamodb:PutItem",
            "dynamodb:DeleteItem"
        ]
        Resource = "arn:aws:dynamodb:us-east-1:${var.global_account_id}:table/rhresume_frontend_state_global"
    }]
  })
  provider = aws.global
}

resource "aws_iam_role_policy_attachment" "global_dynamo" {
  role       = aws_iam_role.lock_dynamo_role.name
  policy_arn = aws_iam_policy.global_dynamo.arn
  provider = aws.global
}
