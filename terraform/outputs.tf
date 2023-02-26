#####################################################################################
#                                   aws_instance.jenkins
#####################################################################################


output "jenkins_ami_jenkins" {
  value = aws_instance.jenkins.ami
}

output "jenkins_arn" {
  value = aws_instance.jenkins.arn
}

output "jenkins_private_ip" {
  value = aws_instance.jenkins.private_dns
}

output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_dns
}

output "jenkins_subnet_id" {
  value = aws_instance.jenkins.subnet_id 
}

output "jenkinsr_vpc_security_group_ids" {
  value = aws_instance.jenkins.vpc_security_group_ids
}

output "jenkins_tags_all" {
  value = aws_instance.jenkins.tags_all
}


#####################################################################################
#                                   aws_instance.ci-dev
#####################################################################################


output "ci-dev_ami" {
  value = aws_instance.ci-dev.ami
}

output "ci-dev_arn" {
  value = aws_instance.ci-dev.arn
}

output "ci-dev_private_ip" {
  value = aws_instance.ci-dev.private_dns
}

output "ci-dev_public_ip" {
  value = aws_instance.ci-dev.public_dns
}

output "ci-dev_subnet_id" {
  value = aws_instance.ci-dev.subnet_id 
}

output "ci-dev_vpc_security_group_ids" {
  value = aws_instance.ci-dev.vpc_security_group_ids
}

output "ci-dev_tags_all" {
  value = aws_instance.ci-dev.tags_all
}

#####################################################################################
#                                   aws_internet_gateway.IGW
#####################################################################################


output "AWS_Internet_Gateway" {
  value = aws_internet_gateway.IGW.id
}

output "AWS_Internet_Gateway_vpc_id" {
  value = aws_internet_gateway.IGW.vpc_id
}

output "AWS_Internet_Gateway_tags_all" {
  value = aws_internet_gateway.IGW.tags_all
}


#####################################################################################
#                                   aws_security_group.Security_Group
#####################################################################################


output "Security_Group_arn" {
  value = aws_security_group.Security_Group.arn
}
output "Security_Group_id" {
  value = aws_security_group.Security_Group.id
}

output "Security_Group_vpc_id" {
  value = aws_security_group.Security_Group.vpc_id
}




