resource "aws_s3_bucket" "s3" {
  bucket = var.bucket_name
  force_destroy = var.force_destroy

  tags = {
    Name     = var.bucket_name
    Project  = var.tags.Project
    BudgetId = var.tags.BudgetId
    Env      = var.environment
  }
}

resource "aws_s3_bucket_versioning" "s3_version" {
  count  = var.enable_versioning ? 1 : 0
  bucket = aws_s3_bucket.s3.id

  versioning_configuration {
    status = "Enabled"
  }
}
