data "archive_file" "lambda" {
  type        = "zip"
  source_file = "../src/lambda.py"
  output_path = "lambda_function_payload.zip"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    actions = ["lambda:InvokeFunction"]
  }
}

resource "aws_lambda_function" "demo_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_payload.zip"
  function_name = "demo_lambda_function"
  role          = "arn:aws:iam::981361020538:role/my-role"
  handler       = "lambda.run_glue_job"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.10"
}
