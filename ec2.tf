resource "aws_instance" "ansible-ec2" {
   ami = var.ami
   instance_type = var.instance-type
   associate_public_ip_address = true
   key_name = var.keyname
   vpc_security_group_ids = [var.security-group]
}