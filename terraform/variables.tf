#
variable "service_name" {
  default = "Final Project"
}

# -------------------------------------------------------------------

variable "region" {
  description = "Configure the AWS Provider"
  type        = string
  default     = "eu-west-1"
}

# --------------------------------------------------------------------


variable "access-key-name" {
  description = "AWS ec2 key name: "
  default = "ec2-key"
}



variable "instance_type" {
  description = "Enter Instance Type"
  type        = string
  default     = "t3.small" 
}

variable "ami_jenkins" {
   description = "instance for Jenkins"
   type        = string
   default     = "ami-06d94a781b544c133"
}

variable "ami_ci-dev" {
   description = "for CI/QA environments"
   type        = string
   default     = "ami-06d94a781b544c133"
}



variable "ec2_name_jenkins" {
    description = "EC2 name for Jenkins"
    type        = string
    default     = "Main_Server_Jenkins"
}

variable "ec2_name_CI_QA" {
    description = "EC2 name for CI/QA environments"
    type        = string
    default     = "CI/QA environments"
}



# --------------------------------------------------------------------

variable "ec2_private_ip_jenkins" {
    description = "EC2 name for instance 1"
    type        = string
    default     = "192.168.11.10"
}

variable "ec2_private_ip_ci-dev" {
    description = "EC2 name for instance 2"
    type        = string
    default     = "192.168.11.11"
}


# --------------------------------------------------------------------

variable "main_vpc_cidr" {
    type    = string
    default = "192.168.11.0/27"
 }
 
 variable "main_publicsubnets_cidr" {
    type    = string
    default = "192.168.11.0/28"
 }


# --------------------------------------------------------------------

variable "allow_ports" {
  description = "List of Ports to open for server"
  type        = list
  default     = [ "80", "443", "22", "8080", "8090", "8092" ]
  #default     = [ "80", "443", "22", "3306", "8080", "8090", "8092" ]
}

variable "commom_tags" {
  description = "Common Tags to apply to all resources"
  type        = map
  default     = {
    Name    = "Final Project"
    Owner   = "DevOps Student"
    Project = "Final Project (L1 EPAM)"
  }
}

# --------------------------------------------------------------------
