#####################################################################################
#                                          Credentials
#####################################################################################

provider "aws" {
  region     = var.region
#  shared_credentials_file = "$HOME/aws/credentials"
#  profile = "default"
}

#####################################################################################
#                                         EC2 Key
#                                     Create Key-pair
#####################################################################################

resource "tls_private_key" "ssh-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh-key-bastion" {
  content         = tls_private_key.ssh-key.private_key_pem
  filename        = "ec2-key-dev.pem"
  file_permission = "0600"
}

resource "aws_key_pair" "key-bastion" {
  key_name = var.access-key-name
  public_key = tls_private_key.ssh-key.public_key_openssh
}

#####################################################################################
#                                      Bastion Hosts
#####################################################################################

resource "aws_instance" "bastion" {
  ami             = var.ami-bastion
  instance_type = var.instance-type
  subnet_id       = var.public-subnet-a
  security_groups = [var.security-group]
  key_name        = var.access-key-name

  user_data = <<-EOL
  #!/bin/bash -xe

  sudo apt-get update
  sudo apt-get install -y nginx
  sudo systemctl start nginx
  EOL

  tags            = {
    Name = "bastion hosts ${var.project-name}"
  }
}

#####################################################################################
#                                  Private Servers
#####################################################################################

resource "aws_instance" "private" {
  ami             = var.ami-bastion
  instance_type   = var.instance-type
  subnet_id       = var.private-subnet-a
  security_groups = [var.security-group]
  key_name        = var.access-key-name


  user_data = <<-EOL
  #!/bin/bash -xe

  sudo apt-get update
  sudo apt-get install -y nginx
  sudo systemctl start nginx
  EOL

  tags            = {
    Name = "DataBases ${var.project-name}"
  }
}
#-------------------------------------------------------