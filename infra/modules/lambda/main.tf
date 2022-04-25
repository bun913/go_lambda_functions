resource "aws_iam_role" "lambda_ec2_stop" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_ec2_stop" {
  name = "${var.prefix}-ec2_stop"
  role = aws_iam_role.lambda_ec2_stop.name

  policy = templatefile("${path.module}/iam/ec2_stop_policy.json", {
    PROJECT = var.tags.Project
  })
}

data "archive_file" "lambda_ec2_stop" {
  type        = "zip"
  source_dir  = "${path.module}/functions/InitialCode"
  output_path = "tmp/InitialCode.zip"
}

resource "aws_lambda_function" "lambda_ec2_stop" {
  function_name = "${var.tags.Project}StopEC2"
  role          = aws_iam_role.lambda_ec2_stop.arn
  handler       = "main"
  filename      = data.archive_file.lambda_ec2_stop.output_path
  runtime       = "go1.x"

}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_ec2_stop.id
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_night20.arn
}
