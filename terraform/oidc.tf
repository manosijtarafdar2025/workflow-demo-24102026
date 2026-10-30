
locals {
  github_oidc_subject = (
    var.github_owner_id != "" && var.github_repository_id != ""
    ? "repo:${var.github_owner}@${var.github_owner_id}/${var.github_repository}@${var.github_repository_id}:ref:refs/heads/${var.github_branch}"
    : "repo:${var.github_owner}/${var.github_repository}:ref:refs/heads/${var.github_branch}"
  )
}

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  tags = {
    Name      = "github-actions-oidc"
    ManagedBy = "Terraform"
    Project   = "python-app"
  }
}

data "aws_iam_policy_document" "github_actions_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [
        aws_iam_openid_connect_provider.github.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = [local.github_oidc_subject]
    }
  }
}
