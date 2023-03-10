#################################################################################
#                                  Credentials
#################################################################################

provider "aws" {
  region     = var.region
 # shared_credentials_file = "$HOME/aws/credentials"
#  profile = "default"
}
#################################################################################
#                                  VPC
#################################################################################
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr-for-vpc
  enable_dns_hostnames = true
  tags                 = {
    Name = "vpc ${var.project-name}"
  }
}


#################################################################################
#                               Private Subnets
#################################################################################

resource "aws_subnet" "private" {
  cidr_block        = var.cidr-private-a
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.availability-zone-a
  tags              = {
    Name = "private-A ${var.project-name}"
  }
}

#################################################################################
#                               Public Subnets
#################################################################################
resource "aws_subnet" "public" {
  cidr_block              = var.cidr-public-a
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  availability_zone       = var.availability-zone-a
  tags                    = {
    Name = "public-A ${var.project-name}"
  }
}

#################################################################################
#                               Internet Gateway
#################################################################################


resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.vpc.id
  tags   = {
    Name = "internetGateway ${var.project-name}"
  }
}

#################################################################################
#                           Create Elastic IP
#################################################################################

resource "aws_eip" "lb" {
    vpc = true
}

#################################################################################
#                              Nat Gateway 
#################################################################################

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.public.id
  tags          = {
    Name = "natGateway ${var.project-name}"
  }
}


#################################################################################
#                                  RoutTables IGW
#################################################################################

resource "aws_route_table" "for_public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.anywhere-cidr
    gateway_id = aws_internet_gateway.IGW.id
  }

  route {
    cidr_block = var.anywhere-cidr
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "publicRouteTable ${var.project-name}"
  }
}

#################################################################################
#                        RouteTables Association for Public
#################################################################################

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.for_public.id
}

#################################################################################
#                              RoutTables NAT
#################################################################################

resource "aws_route_table" "nat_for_private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.anywhere-cidr
    gateway_id = aws_nat_gateway.nat.id
  }

  route {
    cidr_block = var.anywhere-cidr
    gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "privateRouteTable ${var.project-name}"
  }
}


#################################################################################
#RouteTables Association for Private
#################################################################################

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.nat_for_private.id
}



#################################################################################
#                                      ACL
#################################################################################

resource "aws_network_acl" "acl" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = var.anywhere-cidr
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.anywhere-cidr
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 1
    action     = "allow"
    cidr_block = var.anywhere-cidr
    from_port  = 22
    to_port    = 22
  }

  tags = {
    Name = "acl"
  }
}



#################################################################################
#                       Security Group for Bastion
#################################################################################


resource "aws_security_group" "bastion" {
  vpc_id      = aws_vpc.vpc.id
  name        = "bastion-host ${var.project-name}"
  description = "ssh-http-https"

  ####Inbound rules
  ingress {
    from_port   = -1
    protocol    = "icmp"
    to_port     = -1
    cidr_blocks = [var.anywhere-cidr]
  }

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = [var.anywhere-cidr]
  }

  ###Outbound rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.anywhere-cidr]
  }
  tags = {
    Name = "security terraform bastion ${var.project-name}"
  }
}



