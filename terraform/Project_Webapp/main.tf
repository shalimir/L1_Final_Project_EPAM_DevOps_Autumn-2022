#####################################################################################
#                                   Terraform-backend
#####################################################################################

terraform {
  backend                     "s3" {
    bucket                  = "l1final--lvladymirshaly--terraform--state"
    key                     = "dev/network/terraform.tfstate"  #name of darictory= path
    region                  = "eu-west-1"
  }
}

#Credentials
provider "aws" {
  region     = var.region
#  shared_credentials_file = "$HOME/aws/credentials"
#  profile = "default"
}

#####################################################################################
#                                      VPC
#####################################################################################

module "vpc" {
  source = "../modules/vpc"

  project-name = var.project-name
  region = var.region
  cidr-for-vpc = var.cidr-for-vpc
  cidr-public-a = var.cidr-public-a
  cidr-private-a = var.cidr-private-a
  availability-zone-a = var.availability-zone-a

  /*cidr-for-vpc-2 = var.cidr-for-vpc-2
  cidr-public-a-2 = var.cidr-public-a-2
  cidr-private-a-2 = var.cidr-private-a-2
  availability-zone-a-2 = var.availability-zone-a-2*/
  anywhere-cidr = var.anywhere-cidr

}

#####################################################################################
##                                  Bastion Hosts
#####################################################################################

module "ec2" {
  source = "../modules/ec2"

  project-name = var.project-name
  region = var.region
  access-key-name = var.access-key-name
  ami-bastion = var.ami-bastion
  instance-type = var.instance-type
  public-subnet-a = module.vpc.public-subnet-a
  private-subnet-a = module.vpc.private-subnet-a
  security-group = module.vpc.security-group
  /*public-subnet-a-2 = module.vpc.public-subnet-a-2
  private-subnet-a-2 = module.vpc.private-subnet-a-2
  security-group2 = module.vpc.security-group2*/

}
#-------------------------------------------------------


#####################################################################################
##                                  Docker ECS
#####################################################################################


module "Docker_ECS_AWS" {
  source = "../modules/Docker_ECS_AWS"
}
#-------------------------------------------------------
