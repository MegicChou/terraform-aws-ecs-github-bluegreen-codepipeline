
resource "aws_codedeploy_app" "app_deploy" {
  name             = "${var.cluster_name}-deploy"
  compute_platform = "ECS"
}

// 部屬群組 iam 角色權限
resource "aws_iam_role" "app_deploy_group_iam_role" {
  name               = "${var.cluster_name}-deploy-group-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "app_deploy_group_iam_role_policy" {
  name   = "${aws_iam_role.app_deploy_group_iam_role.name}-policy"
  role   = aws_iam_role.app_deploy_group_iam_role.name
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "codedeploy:*",
                "ecs:DescribeServices",
                "ecs:CreateTaskSet",
                "ecs:UpdateServicePrimaryTaskSet",
                "ecs:DeleteTaskSet",
                "elasticloadbalancing:DescribeTargetGroups",
                "elasticloadbalancing:DescribeListeners",
                "elasticloadbalancing:ModifyListener",
                "elasticloadbalancing:DescribeRules",
                "elasticloadbalancing:ModifyRule",
                "lambda:InvokeFunction",
                "cloudwatch:DescribeAlarms",
                "sns:Publish",
                "s3:GetObject",
                "s3:GetObjectVersion"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "iam:PassRole"
            ],
            "Effect": "Allow",
            "Resource": "*",
            "Condition": {
                "StringLike": {
                    "iam:PassedToService": [
                        "ecs-tasks.amazonaws.com"
                    ]
                }
            }
        }
    ]
}
EOF
}

// 部屬群組
resource "aws_codedeploy_deployment_group" "app_deploy_group" {
  app_name               = aws_codedeploy_app.app_deploy.name
  deployment_group_name  = aws_codedeploy_app.app_deploy.name
  service_role_arn       = aws_iam_role.app_deploy_group_iam_role.arn
  depends_on             = [aws_codedeploy_app.app_deploy]
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = var.cluster_name
    service_name = var.service_name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [var.alb_listen_arn]
      }

      test_traffic_route {
        listener_arns = [var.alb_listen_testing_arn]
      }

      target_group {
        name = var.alb_target_group_blue_name
      }

      target_group {
        name = var.alb_target_group_green_name
      }
    }
  }
}

