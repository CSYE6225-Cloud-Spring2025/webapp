packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "> 1.0.0, <2.0.0"
    }
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = "> 1.0.0, <2.0.0"
    }
  }
}

locals {
  timestamp  = formatdate("YYYYMMDD-hhmm", timestamp())
  image_name = "gcp-webapp-packer-linux-${local.timestamp}"
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

# GCP image build
source "googlecompute" "webapp-ubuntu" {
  image_name              = local.image_name
  image_description       = "GCP image for Assignment 4"
  project_id              = var.gcp_project_id
  machine_type            = var.gcp_machine_type
  zone                    = var.gcp_zone
  source_image            = var.gcp_image
  source_image_project_id = [var.gcp_image_project]
  ssh_username            = var.ssh_username
  disk_size               = 10
  disk_type               = "pd-ssd"
}

build {
  name = "webapp-packer"
  sources = [
    "source.amazon-ebs.webapp-ubuntu",
    "source.googlecompute.webapp-ubuntu"
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

  post-processor "shell-local" {
    only = ["source.googlecompute.webapp-ubuntu"]
    inline = [
      "gcloud compute images add-iam-policy-binding ${local.image_name} --project=${var.gcp_project_id} --member='project:${var.gcp_demo_account}' --role='roles/compute.imageUser'"
    ]
  }
}