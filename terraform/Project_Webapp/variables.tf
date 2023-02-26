#####################################################################################
#                                        General
#####################################################################################

variable "project-name" {
  description = "Name of Project"
  default = "prod-Final Project (L1 EPAM)"
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
  default = "ec2-key-dev.pem"
}


variable "ami-bastion" {
  description = "AWS Instance ami: "
  default = "ami-06d94a781b544c133"

}
variable "instance-type" {
  description = "AWS Instance type: "
  default = "t3.xlarge"
}




#####################################################################################
#                                            VPC 1
#####################################################################################

variable "cidr-for-vpc" {
  description = "CIDR block for VPC"
  default = "192.168.0.0/16"
}
variable "cidr-public-a" {
  description = "CIDR  Block for Public Subnet - A"
  default = "192.168.1.0/24"
}
variable "cidr-private-a" {
  description = "CIDR Block for Public Subnet - A"
  default = "192.168.2.0/24"
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
