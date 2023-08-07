resource "aws_iam_role" "lambda_role" {
  name = "lambda_start_stop"

  assume_role_policy = <<POLICY
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
POLICY
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_start_stop_policy"
  role = aws_iam_role.lambda_role.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances",
                "ec2:StopInstances",
                "ec2:StartInstances",
                "rds:DescribeDBInstances",
                "rds:StopDBInstance",
                "rds:StartDBInstance",
                "rds:ListTagsForResource",
                "autoscaling:UpdateAutoScalingGroup",
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:SuspendProcesses",
                "autoscaling:ResumeProcesses"
            ],
            "Resource": "*"
        }
    ]
}
POLICY
}

resource "aws_iam_policy" "cloudwatch_events_policy" {
  name = "cloudwatch_events_policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "lambda:InvokeFunction"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cloudwatch_events_attachment" {
  policy_arn = aws_iam_policy.cloudwatch_events_policy.arn
  role       = aws_iam_role.cloudwatch_events_role.name
}


resource "aws_iam_role" "cloudwatch_events_role" {
  name = "cloudwatch_events_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "scheduler.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
