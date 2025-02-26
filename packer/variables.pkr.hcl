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
  default     = "ami-04b4f1a9cf54c11d0"
}

variable "ssh_username" {
  type        = string
  description = "SSH username"
  default     = "ubuntu"
}

variable "subnet_id" {
  type        = string
  description = "Subnet id in default VPC"
  default     = "subnet-04fe1d51bca2972a6"
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