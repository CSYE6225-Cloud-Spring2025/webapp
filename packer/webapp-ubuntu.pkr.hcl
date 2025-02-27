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

# AWS AMI build
source "amazon-ebs" "webapp-ubuntu" {
  ami_name        = "webapp_packer_linux${formatdate("YYYY-MM-DD_HH-mm", timestamp())}"
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
  image_name          = "webapp-packer-linux${formatdate("YYYY-MM-DD-HH-mm", timestamp())}"
  image_description   = "GCP image for Assignment 4"
  project_id          = var.gcp_project_id
  machine_type        = var.gcp_machine_type
  zone                = var.gcp_zone
  source_image        = var.gcp_image_family
  source_image_family = null
  image_project_id    = var.gcp_image_project
  ssh_username        = var.ssh_username
  disk_size           = 8
  disk_type           = "pd-ssd"
  on_host_maintenance = "TERMINATE"
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
}
