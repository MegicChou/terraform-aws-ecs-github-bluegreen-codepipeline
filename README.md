
修改：https://github.com/tmknom/terraform-aws-codepipeline-for-ecs

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_project.app_build](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codedeploy_app.app_deploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_app) | resource |
| [aws_codedeploy_deployment_group.app_deploy_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_deployment_group) | resource |
| [aws_codepipeline.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_codepipeline_webhook.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline_webhook) | resource |
| [aws_iam_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.app_deploy_group_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.codebuild_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.app_deploy_group_iam_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.codebuild_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [random_id.secret_token](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_alias.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_alias) | data source |
| [template_file.codebuild_policy](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_listen_arn"></a> [alb\_listen\_arn](#input\_alb\_listen\_arn) | AWS alb listen ARN | `string` | n/a | yes |
| <a name="input_alb_listen_testing_arn"></a> [alb\_listen\_testing\_arn](#input\_alb\_listen\_testing\_arn) | AWS alb listen testing ARN | `string` | n/a | yes |
| <a name="input_alb_target_group_blue_name"></a> [alb\_target\_group\_blue\_name](#input\_alb\_target\_group\_blue\_name) | AWS ALB Target Group Name | `string` | n/a | yes |
| <a name="input_alb_target_group_green_name"></a> [alb\_target\_group\_green\_name](#input\_alb\_target\_group\_green\_name) | AWS ALB Target Group Name | `string` | n/a | yes |
| <a name="input_artifact_bucket_name"></a> [artifact\_bucket\_name](#input\_artifact\_bucket\_name) | The S3 Bucket name of artifacts. | `string` | n/a | yes |
| <a name="input_branch"></a> [branch](#input\_branch) | The name of the branch. | `string` | `"master"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the ECS Cluster. | `string` | n/a | yes |
| <a name="input_code_build_envs"></a> [code\_build\_envs](#input\_code\_build\_envs) | https://www.terraform.io/docs/language/values/variables.html | <pre>list(object({<br>    name : string,<br>    value : string<br>  }))</pre> | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the all resources. | `string` | `"Managed by Terraform"` | no |
| <a name="input_encryption_key_id"></a> [encryption\_key\_id](#input\_encryption\_key\_id) | The KMS key ARN or ID. | `string` | `""` | no |
| <a name="input_file_name"></a> [file\_name](#input\_file\_name) | The file name of the image definitions. | `string` | `"imagedefinitions.json"` | no |
| <a name="input_filter_json_path"></a> [filter\_json\_path](#input\_filter\_json\_path) | The JSON path to filter on. | `string` | `"$.ref"` | no |
| <a name="input_filter_match_equals"></a> [filter\_match\_equals](#input\_filter\_match\_equals) | The value to match on (e.g. refs/heads/{Branch}). | `string` | `"refs/heads/{Branch}"` | no |
| <a name="input_github_oauth_token"></a> [github\_oauth\_token](#input\_github\_oauth\_token) | The OAuth Token of GitHub. | `string` | n/a | yes |
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | Path in which to create the IAM Role and the IAM Policy. | `string` | `"/"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the pipeline | `string` | n/a | yes |
| <a name="input_poll_for_source_changes"></a> [poll\_for\_source\_changes](#input\_poll\_for\_source\_changes) | Specify true to indicate that periodic checks enabled. | `string` | `false` | no |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | The name of the repository. | `string` | n/a | yes |
| <a name="input_repository_owner"></a> [repository\_owner](#input\_repository\_owner) | The owner of the repository. | `string` | n/a | yes |
| <a name="input_secret_token"></a> [secret\_token](#input\_secret\_token) | The secret token for the GitHub webhook. | `string` | `""` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The name of the ECS Service. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources. | `map(string)` | `{}` | no |
| <a name="input_webhook_events"></a> [webhook\_events](#input\_webhook\_events) | A list of events which should trigger the webhook. | `list(string)` | <pre>[<br>  "push"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codepipeline_arn"></a> [codepipeline\_arn](#output\_codepipeline\_arn) | The codepipeline ARN. |
| <a name="output_codepipeline_id"></a> [codepipeline\_id](#output\_codepipeline\_id) | The codepipeline ID. |
| <a name="output_codepipeline_webhook_id"></a> [codepipeline\_webhook\_id](#output\_codepipeline\_webhook\_id) | The CodePipeline webhook's ARN. |
| <a name="output_codepipeline_webhook_url"></a> [codepipeline\_webhook\_url](#output\_codepipeline\_webhook\_url) | The CodePipeline webhook's URL. POST events to this endpoint to trigger the target. |
| <a name="output_iam_policy_arn"></a> [iam\_policy\_arn](#output\_iam\_policy\_arn) | The ARN assigned by AWS to this IAM Policy. |
| <a name="output_iam_policy_description"></a> [iam\_policy\_description](#output\_iam\_policy\_description) | The description of the IAM Policy. |
| <a name="output_iam_policy_document"></a> [iam\_policy\_document](#output\_iam\_policy\_document) | The policy document of the IAM Policy. |
| <a name="output_iam_policy_id"></a> [iam\_policy\_id](#output\_iam\_policy\_id) | The IAM Policy's ID. |
| <a name="output_iam_policy_name"></a> [iam\_policy\_name](#output\_iam\_policy\_name) | The name of the IAM Policy. |
| <a name="output_iam_policy_path"></a> [iam\_policy\_path](#output\_iam\_policy\_path) | The path of the IAM Policy. |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the IAM Role. |
| <a name="output_iam_role_create_date"></a> [iam\_role\_create\_date](#output\_iam\_role\_create\_date) | The creation date of the IAM Role. |
| <a name="output_iam_role_description"></a> [iam\_role\_description](#output\_iam\_role\_description) | The description of the IAM Role. |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | The name of the IAM Role. |
| <a name="output_iam_role_unique_id"></a> [iam\_role\_unique\_id](#output\_iam\_role\_unique\_id) | The stable and unique string identifying the IAM Role. |
