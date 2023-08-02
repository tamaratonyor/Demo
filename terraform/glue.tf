resource "aws_glue_job" "demo-job" {
  name     = "kubra-demo-job"
  role_arn = "arn:aws:iam::981361020538:role/my-role"

  command {
    script_location = "s3://script-bucket-kubra-demo/glue.py"
  }
  glue_version = "3.0"
  default_arguments = {
    "--job-language" = "Python3"
  }
}