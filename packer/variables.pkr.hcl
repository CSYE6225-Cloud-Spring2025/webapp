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
  default     = "ami-id"
}

variable "ssh_username" {
  type        = string
  description = "SSH username"
  default     = "ubuntu"
}

variable "aws_subnet_id" {
  type        = string
  description = "AWS Subnet id in default VPC"
  default     = "subnet-id"
}

variable "aws_demo_account" {
  type        = string
  description = "AWS demo account ID"
  default     = "demo-account-id"
}

variable "DB_USER" {
  type        = string
  description = "Database user"
  default     = "root"
}

variable "DB_HOST" {
  type        = string
  description = "Database host"
  default     = "localhost"
}

variable "DB_PASSWORD" {
  type        = string
  description = "Database password"
  default     = "password"
}

variable "DB_NAME" {
  type        = string
  description = "Database name"
  default     = "webapp"
}

variable "PORT" {
  type        = string
  description = "Application port"
  default     = "3001"
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