

resource "aws_lambda_function" "ec2_shutdown" {
  filename      = "${path.module}/resources/ec2_shutdown.zip"
  function_name = "ec2_shutdown"
  role          = aws_iam_role.lambda_role.arn
  handler       = "ec2_shutdown.lambda_handler"
  runtime       = "python3.8"
  timeout       = 30
}

resource "aws_lambda_function" "ec2_start" {
  filename      = "${path.module}/resources/ec2_start.zip"
  function_name = "ec2_start"
  role          = aws_iam_role.lambda_role.arn
  handler       = "ec2_start.lambda_handler"
  runtime       = "python3.8"
  timeout       = 30
}


resource "aws_lambda_function" "rds_shutdown" {
  filename      = "${path.module}/resources/rds_shutdown.zip"
  function_name = "rds_shutdown"
  role          = aws_iam_role.lambda_role.arn
  handler       = "rds_shutdown.lambda_handler"
  runtime       = "python3.8"
  timeout       = 30
}

resource "aws_lambda_function" "rds_start" {
  filename      = "${path.module}/resources/rds_start.zip"
  function_name = "rds_start"
  role          = aws_iam_role.lambda_role.arn
  handler       = "rds_start.lambda_handler"
  runtime       = "python3.8"
  timeout       = 30
}

resource "aws_lambda_function" "asg_shutdown" {
  filename      = "${path.module}/resources/asg_shutdown.zip"
  function_name = "asg_shutdown"
  role          = aws_iam_role.lambda_role.arn
  handler       = "asg_shutdown.lambda_handler"
  runtime       = "python3.8"
  timeout       = 30
}

resource "aws_lambda_function" "asg_start" {
  filename      = "${path.module}/resources/asg_start.zip"
  function_name = "asg_start"
  role          = aws_iam_role.lambda_role.arn
  handler       = "asg_start.lambda_handler"
  runtime       = "python3.8"
  timeout       = 30
}










