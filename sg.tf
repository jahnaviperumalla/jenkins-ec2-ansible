variable "port_values" {
	type = list
	default = "port_list"
}

resource "aws_security_group" "main" {
   count = length(var.port_values)
   name   = port-$[count.index]
   vpc_id = data.aws_vpc.main.id
   description = ingress.value.description
   from_port   = element(var.port_list,count.index)
   to_port     = element(var.port_list,count.index)
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
      
   

   tags = {
      Name = "AWS security group dynamic block"
   }
}
