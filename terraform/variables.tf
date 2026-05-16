variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}

variable "ami_id" {
  description = "Ubuntu 22.04 AMI ID"
  type        = string
  default     = "ami-0f58b397bc5c1f2e8"
}

variable "key_name" {
  description = "AWS Key Pair name"
  type        = string
  default     = "skillpulse-key"
}

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed to SSH into the EC2 instance. Set this to your public IP /32 for production."
  type        = string
  default     = "10.0.0.0/8"
}
