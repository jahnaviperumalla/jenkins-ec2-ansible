resource "aws_instance" "ansible-ec2" {
   ami = "ami1"
   instance_type = "type1"
   associate_public_ip_address = true
   key_name = "keyname1"
   vpc_security_group_ids = ["sg1"]
}