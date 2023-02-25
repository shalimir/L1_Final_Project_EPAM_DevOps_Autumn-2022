#####################################################################################
#                                       Bastion Host
#####################################################################################


output "bastion-server-ip" {
  value = aws_instance.bastion.public_ip
}

output "private-server-ip" {
  value = aws_instance.bastion.private_ip
}

output "instance" {
  value = aws_instance.bastion.id
}