resource "aws_cloudwatch_event_rule" "every_night20" {
  name                = "every_night20"
  description         = "毎日20時に稼働"
  is_enabled          = true
  schedule_expression = "cron(00 12 * * ? *)"
}

resource "aws_cloudwatch_event_target" "lambda_ec2_stop" {
  rule = aws_cloudwatch_event_rule.every_night20.name
  arn  = aws_lambda_function.lambda_ec2_stop.arn
}
