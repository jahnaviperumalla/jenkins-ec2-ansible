resource "aws_instance" "ansible-ec2" {
   ami = var.ami1
   instance_type = instance-type1
   associate_public_ip_address = true
   key_name = var.keyname1
   vpc_security_group_ids = [var.security-group1]
}