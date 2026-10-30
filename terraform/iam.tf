resource "aws_iam_policy" "github_actions_ecr_policy" {
  name        = "github-actions-ecr-policy"
  description = "Allow GitHub Actions to push images to ECR"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "ECRAuthorization"
        Effect   = "Allow"
        Action   = ["ecr:GetAuthorizationToken"]
        Resource = "*"
      },
      {
        Sid    = "PushPythonAppImage"
        Effect = "Allow"
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
        Resource = aws_ecr_repository.python_app.arn
      }
    ]
  })
}


resource "aws_iam_role" "github_actions_ecr_role" {
  name = "github-actions-ecr-role"
  assume_role_policy = data.aws_iam_policy_document.github_actions_trust.json
}

resource "aws_iam_role_policy_attachment" "github_actions_ecr_attachment" {
  role       = aws_iam_role.github_actions_ecr_role.name
  policy_arn = aws_iam_policy.github_actions_ecr_policy.arn
}
