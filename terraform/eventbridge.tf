 resource "aws_cloudwatch_event_rule" "S3_Raw_Event" {
   name        = "Raw-Layer-Object-Addition"
   description = "When objects land in the raw layer"
   role_arn = "arn:aws:iam::981361020538:role/my-role"

   event_pattern = <<EOF
        {
        "source": ["aws.s3"],
        "detail-type": ["Object Created"],
        "detail": {
            "bucket": {
            "name": ["raw-bucket-kubra-demo"]
            }
        }
        }
 EOF
 }

resource "aws_cloudwatch_event_target" "example" {
  arn  = aws_lambda_function.demo_lambda.arn
  rule = aws_cloudwatch_event_rule.S3_Raw_Event.id
}
 