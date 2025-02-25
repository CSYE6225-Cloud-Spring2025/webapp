packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "> 1.0.0, <2.0.0"
    }
    # googlecompute = {
    #   source  = "github.com/hashicorp/googlecompute"
    #   version = ">= 0.2.0, < 1.0.0"
    # }
  }
}

# AWS AMI build
source "amazon-ebs" "webapp-ubuntu" {
  ami_name      = "webapp_packer_linux${formatdate("YYYY_MM_DD", timestamp())}"
  ami_description = "AMI for Assignment 4"
  instance_type = var.aws_instance_type
  region        = var.aws_region
  source_ami = var.aws_source_ami
  ssh_username = "ubuntu"
  subnet_id = var.subnet_id

  aws_polling {
    delay_seconds = 120
    max_attempts = 50
  }

  launch_block_device_mappings {
    delete_on_termination = true
    device_name = "/dev/sda1"
    volume_size = 8
    volume_type = "gp2"
  }
}

# # GCE image build
# source "googlecompute" "ubuntu" {
#   project_id      = "your-gcp-project-id"
#   image_name      = "learn-packer-linux-gcp"
#   machine_type    = "n1-standard-1"
#   zone            = "us-central1-a"
#   source_image    = "ubuntu-2204-jammy-v20240215"
#   ssh_username    = "ubuntu"
# }

provisioner "shell" {
  script = "update-os.sh"
}

provisioner "shell" {
  script = "install-dependencies.sh"
}

provisioner "shell" {
  script = "setup-directory.sh"
}

provisioner "file" {
  source = "webapp.service"
  destination = "/tmp/webapp.service"
}

provisioner "shell" {
  script = "setup-user.sh"
}

provisioner "shell" {
  script = "setup-app.sh"
}

build {
  name    = "webapp-packer"
  sources = [
    "source.amazon-ebs.webapp-ubuntu",
    # "source.googlecompute.ubuntu"
  ]

}
