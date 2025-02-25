variable "profile" {
  type        = string
  description = "AWS profile name"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
  default = "us-east-1"
}

variable "aws_instance_type" {
  type        = string
  description = "AWS instance type"
  default = "t2.small"
}

variable "aws_source_ami" {
  type        = string
  description = "AWS Ubuntu source"
  default = "ami-04b4f1a9cf54c11d0"
}

variable "ssh_username" {
  type        = string
  description = "SSH username"
  default = "ubuntu"
}

variable "subnet_id" {
  type = string
  description = "Subnet id in default VPC"
  default = "subnet-04fe1d51bca2972a6"
}