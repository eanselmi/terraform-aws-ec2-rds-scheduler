resource "aws_scheduler_schedule" "ec2_shutdown" {
  for_each   = var.ec2_start_stop_schedules
  name       = "ec2_shutdown_${each.key}"
  group_name = "default"
  flexible_time_window {
    mode = "OFF"
  }
  schedule_expression = each.value["cron_stop"]
  target {
    arn      = aws_lambda_function.ec2_shutdown.arn
    role_arn = aws_iam_role.cloudwatch_events_role.arn
    input    = format("{\n \"tagKey\": %s,\n \"tagValue\": %s\n}", jsonencode("tag:${each.value["tag_key"]}"), jsonencode(each.value["tag_value"]))
  }
}

resource "aws_scheduler_schedule" "ec2_start" {
  for_each   = var.ec2_start_stop_schedules
  name       = "ec2_start_${each.key}"
  group_name = "default"
  flexible_time_window {
    mode = "OFF"
  }
  schedule_expression = each.value["cron_start"]
  target {
    arn      = aws_lambda_function.ec2_start.arn
    role_arn = aws_iam_role.cloudwatch_events_role.arn
    input    = format("{\n \"tagKey\": %s,\n \"tagValue\": %s\n}", jsonencode("tag:${each.value["tag_key"]}"), jsonencode(each.value["tag_value"]))
  }
}


resource "aws_scheduler_schedule" "rds_dev_shutdown" {
  for_each   = var.rds_start_stop_schedules
  name       = "rds_shutdown_${each.key}"
  group_name = "default"
  flexible_time_window {
    mode = "OFF"
  }
  schedule_expression = each.value["cron_stop"]
  target {
    arn      = aws_lambda_function.rds_shutdown.arn
    role_arn = aws_iam_role.cloudwatch_events_role.arn
    input    = format("{\n \"tagKey\": %s,\n \"tagValue\": %s\n}", jsonencode(each.value["tag_key"]), jsonencode(each.value["tag_value"]))
  }
}

resource "aws_scheduler_schedule" "rds_start" {
  for_each   = var.rds_start_stop_schedules
  name       = "rds_start_${each.key}"
  group_name = "default"
  flexible_time_window {
    mode = "OFF"
  }
  schedule_expression = each.value["cron_start"]
  target {
    arn      = aws_lambda_function.rds_start.arn
    role_arn = aws_iam_role.cloudwatch_events_role.arn
    input    = format("{\n \"tagKey\": %s,\n \"tagValue\": %s\n}", jsonencode(each.value["tag_key"]), jsonencode(each.value["tag_value"]))
  }
}
