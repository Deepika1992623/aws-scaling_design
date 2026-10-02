# AWS ECS Scaling Checklist

## Overview

This guide provides step-by-step instructions to use the AWS Scaling Checklist script within the `scaling_module` project. It enables you to validate and display your AWS ECS scaling configuration.

**Files Used:**
- `scaling_checklist.tf` - Terraform configuration that outputs a comprehensive scaling checklist for your AWS WordPress deployment

**Output Includes:**
- Service information (cluster, service, load balancer details)
- Scaling limits and settings (min/max capacity, CPU targets, cooldown periods)
- Optional scaling features (scheduled scaling, multi-metric scaling, step scaling)
- Resource tags 

### Prerequisites

- An existing WordPress project (aws-wp-tf-v5) and also scaling_module folder.
- AWS credentials configured in `terraform.tfvars`
- Terraform installed (version 1.5.7 or later)

### Step-by-Step Instructions

#### Step 1: Download the File

```bash
# Download scaling_checklist.tf to your workspace
cd /home/cloudshell-user
Download scaling-checklist.tf
```

#### Step 2: Move File to scaling_module Project

```bash
# Copy file to the scaling_module directory
mv scaling_checklist.tf scaling_module/
cd scaling_module
```

#### Step 3: Generate Output

Assuming Terraform is installed and the aws-wp-tf-v5 project is running:

```bash
chmod +x use_existing_provider.sh
./use_existing_provider.sh

terraform plan
terraform apply
```
---

### Step 4: View Results

After running `terraform apply`, the scaling configuration summary will be displayed:

```
SERVICE INFORMATION:
Cluster Name:          ecs-wordpress
Service Name:          wp-ecs-svc-tf
Region:                us-east-1
Load Balancer Name:    wp-alb-tf
Target Group Name:     wp-alb-tg-tf

SCALING LIMITS AND SETTINGS:
Minimum Tasks:         1
Maximum Tasks:         3
Target CPU Use:        70%
Scale-Out Cooldown:    60 seconds
Scale-In Cooldown:     300 seconds

OPTIONAL SCALING FEATURES:
Scheduled Scaling:      false
  Scale Up Time:        cron(0 8 * * ? *)
  Scale Down Time:      cron(0 20 * * ? *)

Multi-Metric Scaling:   false
  Target Memory:        70%

Step Scaling:           false
Notifications:          false

TAGS:
Environment:           aws-wp-lab
Project:               aws-wp-tf-poc
Component:             scaling-enhancement
```