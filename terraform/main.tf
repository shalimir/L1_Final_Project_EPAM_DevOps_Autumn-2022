provider "aws" {
  region = var.region                                                          
}

#####################################################################################
#                                   Terraform-backend
#####################################################################################

terraform {
  backend                     "s3" {
    bucket                  = "l1final--lvladymirshaly--terraform--state"
    key                     = "prod/servers/terraform.tfstate"  #name of darictory= path
    region                  = "eu-west-1"
  }
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
  filename        = "ec2-key.pem"
  file_permission = "0600"
}

resource "aws_key_pair" "key-bastion" {
  key_name = var.access-key-name
  public_key = tls_private_key.ssh-key.public_key_openssh
}


resource "aws_instance" "jenkins" {
    ami           = var.ami_jenkins                                          
    instance_type = var.instance_type
    key_name      = var.access-key-name                                         
    
    subnet_id              = aws_subnet.publicsubnets.id
    private_ip             = var.ec2_private_ip_jenkins
    vpc_security_group_ids = [aws_security_group.Security_Group.id]
    associate_public_ip_address = true

    tags = merge (var.commom_tags, {Name = var.ec2_name_jenkins}, {Region  = var.region})                        # MERGE 2 VARIABLES: var.commom_tags(MAP TAGS) & var.region
}


resource "aws_instance" "ci-dev" {
    ami           = var.ami_ci-dev                                                 
    instance_type = var.instance_type                                             
    key_name      = var.access-key-name

    subnet_id              = aws_subnet.publicsubnets.id
    private_ip             = var.ec2_private_ip_ci-dev
    vpc_security_group_ids = [aws_security_group.Security_Group.id]
    associate_public_ip_address = true

    depends_on = [aws_instance.jenkins]

    tags = merge (var.commom_tags, {Name = var.ec2_name_CI_QA}, {Region  = var.region})                           # MERGE 2 VARIABLES: var.commom_tags(MAP TAGS) & var.region 
}



# --------------------------------------------------------------------
# Create the VPC
 resource "aws_vpc" "Main" {

  cidr_block       = var.main_vpc_cidr
  #instance_tenancy = "default"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.service_name}-(VPC)"
  }
}

# Create Internet Gateway and attach it to VPC
resource "aws_internet_gateway" "IGW" {    # Creating Internet Gateway
  vpc_id =  aws_vpc.Main.id               # vpc_id will be generated after we create VPC
  
  tags = {
    Name = "${var.service_name}-(IGW)"
  }
}

# Create a Public Subnets.
resource "aws_subnet" "publicsubnets" {    # Creating Public Subnets
  vpc_id =  aws_vpc.Main.id
  cidr_block = var.main_publicsubnets_cidr       # CIDR block of public subnets
  
  tags = {
    Name = "${var.service_name}-(Public Subnet)"
  }
}

# Route table for Public Subnet
resource "aws_route_table" "PublicRT" {    # Creating RT for Public Subnet
  vpc_id =  aws_vpc.Main.id
    
  route {
    cidr_block = "0.0.0.0/0"               # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.IGW.id
  }
  
  tags = {
    Name = "${var.service_name}-(Route table for Public Subnet)"
  }
}
 
# Route table Association with Public Subnet
resource "aws_route_table_association" "PublicRTassociation" {
  subnet_id = aws_subnet.publicsubnets.id
  route_table_id = aws_route_table.PublicRT.id
} 

# --------------------------------------------------------------------
# Security Group
resource "aws_security_group" "Security_Group" {
  name = "${var.service_name}-(Security_Group)"
  vpc_id = aws_vpc.Main.id

  dynamic "ingress" {
    for_each = var.allow_ports                                                  # VAR allow_ports: [ "80", "443", "22", "8080" ]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    #description = “Allow all incoming ICMP – IPv4 traffic”
    from_port = -1
    to_port = -1
    protocol = "icmp"
    #cidr_blocks = ["0.0.0.0/0"]                                
    cidr_blocks = [aws_subnet.publicsubnets.cidr_block]                        #["192.168.11.0/28"] - Allow ping from specific subnets to AWS EC2
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge (var.commom_tags, {Name = "${var.service_name}-(Security Group)"})
}





