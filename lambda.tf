

resource "aws_lambda_function" "ec2_shutdown" {
  filename      = "resources/ec2_shutdown.zip"
  function_name = "ec2_shutdown"
  role          = aws_iam_role.lambda_role.arn
  handler       = "ec2_shutdown.lambda_handler"
  runtime       = "python3.8"
  timeout       = 30
}

resource "aws_lambda_function" "ec2_start" {
  filename      = "resources/ec2_start.zip"
  function_name = "ec2_start"
  role          = aws_iam_role.lambda_role.arn
  handler       = "ec2_start.lambda_handler"
  runtime       = "python3.8"
  timeout       = 30
}


resource "aws_lambda_function" "rds_shutdown" {
  filename      = "resources/rds_shutdown.zip"
  function_name = "rds_shutdown"
  role          = aws_iam_role.lambda_role.arn
  handler       = "rds_shutdown.lambda_handler"
  runtime       = "python3.8"
  timeout       = 30
}

resource "aws_lambda_function" "rds_start" {
  filename      = "resources/rds_start.zip"
  function_name = "rds_start"
  role          = aws_iam_role.lambda_role.arn
  handler       = "rds_start.lambda_handler"
  runtime       = "python3.8"
  timeout       = 30
}









