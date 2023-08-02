resource "aws_athena_database" "demo_db_athena" {
  name   = "demo_db_athena"
  bucket = aws_s3_bucket.gold_bucket.id
  force_destroy = true
}

resource "aws_glue_crawler" "example" {
  database_name = aws_athena_database.demo_db_athena.name
  name          = "demo-crawler"
  role          = "arn:aws:iam::981361020538:role/my-role"

  s3_target {
    path = "s3://${aws_s3_bucket.gold_bucket.bucket}/gold"
  }
}

resource "aws_athena_workgroup" "demo-work-group" {
  name = "demo-work-group"
  configuration {
    enforce_workgroup_configuration    = true
    publish_cloudwatch_metrics_enabled = true

    result_configuration {
      output_location = "s3://${aws_s3_bucket.output_bucket.bucket}/"

      encryption_configuration {
        encryption_option = "SSE_S3"
      }
    }
  }
}