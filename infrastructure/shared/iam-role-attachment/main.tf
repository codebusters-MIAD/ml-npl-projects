#=======================================================================================================================
# IAM ROLE ATTACHMENT MODULE
#=======================================================================================================================
resource "aws_iam_role" "iam_role" {
  name               = var.iam_role
  assume_role_policy = var.assume_role_policy
  tags = {
    Name     = var.iam_role
    BudgetId = var.tags.BudgetId
    Project  = var.tags.Project
    Env      = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  for_each   = var.arn_policies
  role       = aws_iam_role.iam_role.name
  policy_arn = each.value.arn
}

resource "aws_iam_instance_profile" "iam_instance_profile" {
  count = var.is_required_profile ? 1 : 0
  name  = var.profile_name
  role  = aws_iam_role.iam_role.name
  tags = {
    Name     = var.iam_role
    BudgetId = var.tags.BudgetId
    Project  = var.tags.Project
    Env      = var.environment
  }
}
