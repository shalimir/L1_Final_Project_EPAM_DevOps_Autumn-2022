#####################################################################################
#                                        General
#####################################################################################

variable "project-name" {
  description = "Name of Project"
  default = "AWS"
}

#Credentials
variable "region" {
  description = "AWS Region"
  type = string
  default = "eu-west-1"
}

#EC2 Key
variable "access-key-name" {
  description = "AWS ec2 key name: "
  default = "ec2-key"
}



#####################################################################################
#                                         Bastion Host
#####################################################################################

/*data                          "aws_ami" "latest_webapp_ubuntu" {
  owners                    = ["099720109477"]  #go to the Imeges/AMI/Public_Images/Search with ami incstances you need
  most_recent               = true
  filter {
    name                    = "name"
    values                  = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]              # is AMI name '-*' - meanse the leatest version (most recent)
  }
}*/


variable "ami-bastion" {
  description = "AWS Instance ami: "
  default = "ami-06d94a781b544c133"

}
variable "instance-type" {
  description = "AWS Instance type: "
  default = "t2.micro"
}



#####################################################################################
#                                            VPC 1
#####################################################################################

variable "cidr-for-vpc" {
  description = "CIDR block for VPC"
  default = "10.0.0.0/16"
}
variable "cidr-public-a" {
  description = "CIDR  Block for Public Subnet - A"
  default = "10.0.1.0/24"
}
variable "cidr-private-a" {
  description = "CIDR Block for Public Subnet - A"
  default = "10.0.2.0/24"
}
variable "availability-zone-a" {
  description = "Availability Zone - A"
  default = "eu-west-1a"
}

#####################################################################################
#                                Security Group
#####################################################################################

variable "anywhere-cidr" {
  description = "Allow connection from Anywhere"
  type        = string
  default     = "0.0.0.0/0"
}

/*

#####################################################################################
#                                         VPC 2
#####################################################################################

variable "cidr-for-vpc-2" {
  description = "CIDR block for VPC"
  default = "192.168.0.0/16"
}
variable "cidr-public-a-2" {
  description = "CIDR  Block for Public Subnet - A"
  default = "192.168.1.0/24"
}
variable "cidr-private-a-2" {
  description = "CIDR Block for Public Subnet - A"
  default     = "192.168.2.0/24"
}
variable "availability-zone-a-2" {
  description = "Availability Zone - A"
  default = "eu-central-1a"
}

*/
