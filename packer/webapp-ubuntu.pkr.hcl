packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "> 1.0.0, <2.0.0"
    }
  }
}

# AWS AMI build
source "amazon-ebs" "webapp-ubuntu" {
  ami_name        = "webapp_packer_linux${formatdate("YYYY_MM_DD", timestamp())}"
  ami_description = "AMI for Assignment 4"
  instance_type   = var.aws_instance_type
  region          = var.aws_region
  source_ami      = var.aws_source_ami
  ssh_username    = "ubuntu"
  subnet_id       = var.subnet_id

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
    source      = "./"
    destination = "/tmp/webapp"
  }

  provisioner "shell" {
    script = "install-dependencies.sh"
    environment_vars = [
      "DB_USER=${var.DB_USER}",
      "DB_HOST=${var.DB_HOST}",
      "DB_PASSWORD=${var.DB_PASSWORD}",
      "DB_NAME=${var.DB_NAME}"
    ]
  }

  provisioner "shell" {
    script = "setup-directory.sh"
    environment_vars = [
      "DB_USER=${var.DB_USER}",
      "DB_HOST=${var.DB_HOST}",
      "DB_PASSWORD=${var.DB_PASSWORD}",
      "DB_NAME=${var.DB_NAME}",
      "PORT=${var.PORT}"
    ]
  }

  provisioner "file" {
    source      = "webapp.service"
    destination = "/tmp/webapp.service"
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
