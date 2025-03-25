packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "> 1.0.0, <2.0.0"
    }
  }
}

locals {
  timestamp  = formatdate("YYYYMMDD-hhmm", timestamp())
  image_name = "webapp-packer-linux-${local.timestamp}"
}

# AWS AMI build
source "amazon-ebs" "webapp-ubuntu" {
  ami_name        = local.image_name
  ami_description = "AMI for Assignment 4"
  instance_type   = var.aws_instance_type
  region          = var.aws_region
  source_ami      = var.aws_source_ami
  ssh_username    = var.ssh_username
  subnet_id       = var.aws_subnet_id
  ami_users       = [var.aws_demo_account]

  aws_polling {
    delay_seconds = 120
    max_attempts  = 50
  }

  launch_block_device_mappings {
    delete_on_termination = true
    device_name           = "/dev/sda1"
    volume_size           = 8
    volume_type           = "gp2"
  }
}

build {
  name = "webapp-packer"
  sources = [
    "source.amazon-ebs.webapp-ubuntu"
  ]

  provisioner "shell" {
    script = "update-os.sh"
  }

  provisioner "file" {
    source      = "../"
    destination = "/tmp/webapp/"
  }

  provisioner "shell" {
    script = "install-dependencies.sh"
  }

  provisioner "shell" {
    script = "setup-directory.sh"
  }

  provisioner "shell" {
    script = "setup-user.sh"
    environment_vars = [
      "APP_GROUP=${var.APP_GROUP}",
      "APP_USER=${var.APP_USER}"
    ]
  }

  provisioner "shell" {
    script = "setup-app.sh"
  }
}