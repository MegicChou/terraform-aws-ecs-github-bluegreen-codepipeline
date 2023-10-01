resource "aws_iam_role" "codebuild_role" {
  name               = "${var.cluster_name}-codebuild-role"
  assume_role_policy = file("${path.module}/templates/policies/codebuild_role.json")
}

data "template_file" "codebuild_policy" {
  template = file("${path.module}/templates/policies/codebuild_policy.json")

  vars = {
    aws_s3_bucket_arn = aws_s3_bucket.default.arn
  }
}

resource "aws_iam_role_policy" "codebuild_role_policy" {
  name   = "${var.cluster_name}-codebuild-policy"
  role   = aws_iam_role.codebuild_role.id
  policy = data.template_file.codebuild_policy.rendered
}