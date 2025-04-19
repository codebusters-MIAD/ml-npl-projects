locals {
  image_tag = "${aws_ecr_repository.ecr_repo.repository_url}:${var.ecr_image_tag}"
}


resource "aws_ecr_repository" "ecr_repo" {
  name = local.ecr_repo
  force_delete =  var.force_delete
  lifecycle {
    ignore_changes = [image_scanning_configuration]
  }

  tags = {
    Name     = local.ecr_repo
    Project  = var.tags.Project
    BudgetId = var.tags.BudgetId
    Env      = var.environment
  }
}

resource "null_resource" "ecr_image" {
  triggers = {
    script_file = md5(file("${path.module}/${var.trigger_path}/${var.trigger_script_file}"))
    docker_file = md5(file("${path.module}/${var.trigger_path}/Dockerfile"))
  }

  provisioner "local-exec" {
    command = <<EOF
           aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com
           cd ${path.module}/${var.trigger_path}
           docker buildx build  --platform linux/amd64 --provenance=false -t ${local.image_tag} .
           docker push ${local.image_tag}
       EOF
  }
}
