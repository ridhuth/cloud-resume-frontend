


resource "aws_iam_role" "global_dynamo_role" {
    count      = terraform.workspace != "global" ? 1 : 0

    name = "global_dynamo_role_${terraform.workspace}"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Sid    = ""
                Principal = {
                    AWS = var.dev_account_id
                }
            },
        ]
    })
}


resource "aws_iam_policy" "global_dynamo" {
  count      = terraform.workspace != "global" ? 1 : 0

  name        = "global_dynamo"
  description = "allow assuming global_dynamo role"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "sts:AssumeRole",
        Resource = "arn:aws:iam::${var.global_account_id}:role/${aws_iam_role.global_dynamo_role[0].name}"
    }]
  })
}


resource "aws_iam_role_policy_attachment" "global_dynamo" {
  count      = terraform.workspace != "global" ? 1 : 0

  role       = aws_iam_role.global_dynamo_role[0].name
  policy_arn = aws_iam_policy.global_dynamo[0].arn
}


