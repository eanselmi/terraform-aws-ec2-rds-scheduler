
variable "ec2_start_stop_schedules" {
  description = "Schedules and tags to power off and power on EC2 instances"
  type        = map(map(string))
  default     = {}

}

variable "rds_start_stop_schedules" {
  description = "Schedules and tags to power off and power on RDS instances"
  type        = map(map(string))
  default     = {}
}

variable "asg_start_stop_schedules" {
  description = "Schedules and tags to power off and power on EC2 instances with ASG"
  type        = map(map(string))
  default     = {}
}

variable "aurora_start_stop_schedules" {
  description = "Schedules and tags to power off and power on Aurora clusters"
  type        = map(map(string))
  default     = {}
}

variable "timezone" {
  description = "Timezone for schedule"
  type        = string
  default     = "UTC"
}


