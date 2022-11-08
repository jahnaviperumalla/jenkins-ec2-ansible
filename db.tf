resource "aws_db_instance" "dbname" {
  allocated_storage    = 10
  engine               = "engine_type"
  engine_version       = "version"
  instance_class       = "type"
  name                 = "dbname"
  username             = "user_name"
  password             = "passwd"
  db_subnet_group_name = subnet_group_name
  vpc_security_group_ids = [ "sg_id" ]
  availability_zone    =    az
  skip_final_snapshot       = value
  
  tags = {
    Name = "dbname"
  }
}