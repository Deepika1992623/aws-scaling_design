# scaling_checklist.tf
# This file is a summary AWS Scaling Checklist configuration.

locals {
  # ECS Service Parameters
  ecs_service_config = {
    cluster_name = "ecs-wordpress" 
    service_name = "wp-ecs-svc-tf" 
    region       = "us-east-1"
  }
  # Load Balancer
  alb_config = {
    load_balancer_name = "wp-alb-tf" 
    target_group_name  = "wp-alb-tg-tf" 
  }

  #Auto-Scaling
  capacity_limits = {
    min_capacity = 1
    max_capacity = 3 
  }

  # CPU Tracking
  scaling_policy_config = {
    cpu_target_value = 70 
  }
  # Cooldown Periods
  cooldown_periods = {
    scale_in_cooldown  = 300 
    scale_out_cooldown = 60 
  }
  #Scaling Features Checklist
  scheduled_scaling_status = {
    enabled       = false 
    scale_down_time = "cron(0 20 * * ? *)" 
    scale_up_time   = "cron(0 8 * * ? *)" 
  }

  multi_metric_scaling_status = {
    enabled            = false 
    memory_target_value = 70 
  }

  step_scaling_status = {
    enabled = false 
  }

  notification_status = {
    enabled      = false 
    alert_email  = null 
  }


  base_tags = {
    Environment = "aws-wp-lab"
    Project     = "aws-wp-tf-poc"
    Component   = "scaling-enhancement"
}
}

# --- AWS Scaling Checklist Output ---
output "scaling_configuration_summary" {
  description = "Summary of the AWS scaling setup."
  value = <<-EOT

    SERVICE INFORMATION :
    Cluster Name:          ${local.ecs_service_config.cluster_name}
    Service Name:          ${local.ecs_service_config.service_name}
    Region:                ${local.ecs_service_config.region}
    Load Balancer Name:    ${local.alb_config.load_balancer_name}
    Target Group Name:     ${local.alb_config.target_group_name}

    SCALING LIMITS AND SETTINGS : 
    Minimum Tasks:         ${local.capacity_limits.min_capacity}
    Maximum Tasks:         ${local.capacity_limits.max_capacity}
    Target CPU Use:        ${local.scaling_policy_config.cpu_target_value}%
    Scale-Out Cooldown:    ${local.cooldown_periods.scale_out_cooldown} seconds
    Scale-In Cooldown:     ${local.cooldown_periods.scale_in_cooldown} seconds

    OPTIONAL SCALING FEATURES : 
    Scheduled Scaling:      ${local.scheduled_scaling_status.enabled}
      Scale Up Time:        ${local.scheduled_scaling_status.scale_up_time}
      Scale Down Time:      ${local.scheduled_scaling_status.scale_down_time}

    Multi metric Scaling:   ${local.multi_metric_scaling_status.enabled}
      Target Memory:        ${local.multi_metric_scaling_status.memory_target_value}%

    Step Scaling:           ${local.step_scaling_status.enabled}
    Notifications:          ${local.notification_status.enabled}

    TAG  : 
    Environment:           ${local.base_tags.Environment}
    Project:               ${local.base_tags.Project}
    Component:             ${local.base_tags.Component}

  EOT
}
