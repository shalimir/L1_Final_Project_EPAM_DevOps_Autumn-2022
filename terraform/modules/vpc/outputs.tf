#####################################################################################
#                                       VPC
#####################################################################################

output "vpc" {
  value = aws_vpc.vpc.id
}
output "public-subnet-a" {
  value = aws_subnet.public.id
}
output "private-subnet-a" {
  value = aws_subnet.private.id
}

output "instance" {
  value = aws_eip.lb
}

#####################################################################################
#                                 Security Group
#####################################################################################
output "security-group" {
  value = aws_security_group.bastion.id
}

