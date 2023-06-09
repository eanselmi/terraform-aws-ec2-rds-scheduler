# Terraform module to easily schedule ec2 and rds instances stop/start.

![image](./images/savings.jpg)

## This module will help you reduce expenses by shutting down ec2 and rds instances when they are not needed and turning them on schedule.

<br/>

# How to use it

1. Clone the repository and reference the module in your Terraform code.
   <br/>

Example:

```
module "ec2-rds-scheduler" {
  source                   = "../../modules/ec2-rds-scheduler"
  ec2_start_stop_schedules = var.ec2_start_stop_schedules
  rds_start_stop_schedules = var.rds_start_stop_schedules
}
```

2. Create in your code the following variables.

```
variable "ec2_start_stop_schedules" {
  description = "List of schedules and tags to turn off and turn on ec2 instances"
  type        = map(map(string))
  default     = {}
}


variable "rds_start_stop_schedules" {
  description = "List of schedules and tags to turn off and turn on RDS instances"
  type        = map(map(string))
  default     = {}
}
```

<br/>

3. Using tfvars or defaults in the previous variable declaration, you can declare the schedule for turning off and on ec2 and rds instances. In this example, we are scheduling ec2 instances in the dev environment to turn off at 1:49 am UTC and turn them on at 4:45 am UTC. All ec2 instances with tag env:dev will be affected. For the production environment, we will turn ec2 instances off at 5:10 am and turn them on at 8:44 am (only instances with tag env:prod will be affected by this schedule). Finally, the RDS instances with tag env:dev will be turned off at 3:50 UTC and turned on at 9:45 am. You can add as many schedules as you need.

<br/>

```
ec2_start_stop_schedules = {
  "schedule_dev" = {
    "cron_stop"  = "cron(49 01 ? * * *)"
    "cron_start" = "cron(45 04 ? * * *)"
    "tag_key"    = "env"
    "tag_value"  = "dev"
  }
  "schedule_prod" = {
    "cron_stop"  = "cron(10 5 ? * * *)"
    "cron_start" = "cron(44 8 ? * * *)"
    "tag_key"    = "env"
    "tag_value"  = "prod"
  }

}

rds_start_stop_schedules = {
  "rds_schedule_dev" = {
    "cron_stop"  = "cron(50 3 ? * * *)"
    "cron_start" = "cron(45 9 ? * * *)"
    "tag_key"    = "env"
    "tag_value"  = "dev"
  }
}

```

<br/>

## IMPORTANT: the time must be set in UTC.

<br/>

## If this Terraform module was helpful for you, please let me know. You can find me on LinkedIn.

https://www.linkedin.com/in/nazareno-anselmi/
