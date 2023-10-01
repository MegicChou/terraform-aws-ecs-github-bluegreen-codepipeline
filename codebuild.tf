resource "aws_codebuild_project" "app_build" {
  name          = "${var.cluster_name}-codebuild"
  build_timeout = "60"

  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"

    // https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html
    image           = "aws/codebuild/standard:4.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    dynamic "environment_variable" {
      # https://www.hashicorp.com/blog/hashicorp-terraform-0-12-preview-for-and-for-each
      for_each = var.code_build_envs
      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
      }
    }
  }

  source {
    type = "CODEPIPELINE"
  }
}