
variable "ec2_start_stop_schedules" {
  description = "List of schedules and tags to power off and power on EC2 instances"
  type        = map(map(string))
  default     = {}

}


variable "rds_start_stop_schedules" {
  description = "List of schedules and tags to power off and power on RDS instances"
  type        = map(map(string))
  default     = {}
}
