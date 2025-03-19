variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "aws_instance_type" {
  type        = string
  description = "AWS instance type"
  default     = "t2.small"
}

variable "aws_source_ami" {
  type        = string
  description = "AWS Ubuntu source"
  default     = "aws-source-ami"
}

variable "ssh_username" {
  type        = string
  description = "SSH username"
  default     = "ubuntu"
}

variable "aws_subnet_id" {
  type        = string
  description = "AWS Subnet id in default VPC"
  default     = ""
}

variable "aws_demo_account" {
  type        = string
  description = "AWS demo account ID"
  default     = ""
}

variable "APP_GROUP" {
  type        = string
  description = "Application group"
  default     = "csye6225"
}

variable "APP_USER" {
  type        = string
  description = "Application user"
  default     = "csye6225"
}