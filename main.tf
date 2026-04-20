provider "aws" {
  region = "us-east-1"
}

# Create IAM user
resource "aws_iam_user" "demo_user" {
  name = "terraform-demo-user"
}

# Create policy
resource "aws_iam_policy" "demo_policy" {
  name        = "terraform-demo-policy"
  description = "Simple read-only policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:Describe*",
          "s3:List*"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach policy to user
resource "aws_iam_user_policy_attachment" "attach" {
  user       = aws_iam_user.demo_user.name
  policy_arn = aws_iam_policy.demo_policy.arn
}