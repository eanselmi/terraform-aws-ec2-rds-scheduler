<!-- markdownlint-disable -->

# This Terraform module provides a convenient solution for scheduling the stop and start actions of EC2 and RDS instances. [![Latest Release](https://img.shields.io/github/v/release/eanselmi/ec2-rds-scheduler.svg)](https://github.com/cloudposse/terraform-aws-eks-cluster/releases/latest)

<!-- markdownlint-restore -->

![image](./images/savings.jpg)

## This module is designed to assist you in cost reduction by implementing scheduled shutdowns for ec2 and rds instances during periods of inactivity, and subsequently, powering them back on according to the specified schedule.

<br/>

# How does it work?

## This module will facilitate the deployment of the following resources:

- IAM Roles for Eventbridge to invoke Lambda Functions
- IAM Roles for Lambda Functions to start/stop EC2 and RDS instances
- Eventbridge schedules
- Four Lambda Functions (two for EC2 instances and two for RDS instances)

![image](./images/resources.jpg)

## The EventBridge schedules will serve as triggers for the Lambdas, enabling the start/stop actions on instances as per the specified schedule.

<br/>

# Inputs

| Name                     | Description                                              | Type               | Default | Required |
| ------------------------ | -------------------------------------------------------- | ------------------ | ------- | :------: |
| ec2_start_stop_schedules | Schedules and tags to turn off and turn on EC2 instances | `map(map(string))` | `{}`    |    no    |
| rds_start_stop_schedules | Schedules and tags to turn off and turn on RDS instances | `map(map(string))` | `{}`    |    no    |

<br/>

# How to use it

### 1. Clone the repository or set the source directly against this github reposiroty in your Terraform code.

   <br/>

Example:

```
module "ec2-rds-scheduler" {
  source                   = "../../modules/ec2-rds-scheduler"
  ec2_start_stop_schedules = var.ec2_start_stop_schedules
  rds_start_stop_schedules = var.rds_start_stop_schedules
}
```

or

```
module "ec2-rds-scheduler" {
  source = "github.com/eanselmi/ec2-rds-scheduler?ref=v1.0.0"
  ec2_start_stop_schedules = var.ec2_start_stop_schedules
  rds_start_stop_schedules = var.rds_start_stop_schedules
}
```

Note: If you prefer to utilize a specific module version instead of the latest version, you have the option to specify it at this point. For instance, in this particular example, we employ version 1.0.0.

Please be advised that the inclusion of ec2_start_stop_schedules and rds_start_stop_schedules is entirely optional. You may choose to add either of them based on your specific requirements. In the event that you decide not to include any of these schedules, only the Lambda Functions and IAM roles will be deployed.

<br/>

### 2. To customize the module's behavior, you have two options: either create the following variables in your code or directly modify the variables within the module itself if you prefer not to add variables in your code.

```
variable "ec2_start_stop_schedules" {
  description = "Schedules and tags to turn off and turn on ec2 instances"
  type        = map(map(string))
  default     = {}
}


variable "rds_start_stop_schedules" {
  description = "Schedules and tags to turn off and turn on RDS instances"
  type        = map(map(string))
  default     = {}
}
```

<br/>

### 3. By utilizing tfvars or defaults in the previous variable declaration, or by directly modifying the module if you skipped step 2, you can specify the schedules for turning off and on ec2 and rds instances. In this example, we schedule ec2 instances in the dev environment to turn off at 1:49 am UTC and turn on at 4:45 am UTC. This schedule applies to all ec2 instances tagged with env:dev. Similarly, for the production environment, we schedule ec2 instances to turn off at 5:10 am UTC and turn on at 8:44 am UTC. This schedule affects only instances with the tag env:prod. Lastly, RDS instances tagged with env:dev will be turned off at 3:50 am UTC and turned on at 9:45 am UTC. You have the flexibility to add as many schedules as required.

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

## IMPORTANT: It is crucial to note that the time must be set in UTC.

<br/>

### 4. Please proceed with the application of the changes and enjoy the benefits of the module.

---

<br/>

### We welcome any ideas, corrections, or feedback you may have. Your input is greatly appreciated and will contribute to further improving our module.

<br/>

# [If you found this Terraform module helpful, we would appreciate hearing from you. Please feel free to reach out to me on LinkedIn to share your feedback.](https://www.linkedin.com/in/nazareno-anselmi/)
