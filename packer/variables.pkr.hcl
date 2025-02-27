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

variable "gcp_project_id" {
  type        = string
  description = "GCP project ID"
  default     = "gcp-project-id"
}

variable "gcp_zone" {
  type        = string
  description = "GCP zone"
  default     = "us-east4-a"
}

variable "gcp_image" {
  type        = string
  description = "GCP Ubuntu image"
  default     = "ubuntu-2404-noble-amd64-v20250214"
}

variable "gcp_image_project" {
  type        = string
  description = "GCP Ubuntu image project"
  default     = "ubuntu-os-cloud"
}

variable "gcp_machine_type" {
  type    = string
  default = "e2-small"
}