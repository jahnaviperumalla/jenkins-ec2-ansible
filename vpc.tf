resource "aws_vpc" "demovpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"
tags = {
    Name = "Demo VPC"
  }
}

resource "aws_internet_gateway" "demogateway" {
  vpc_id = "${aws_vpc.demovpc.id}"
}

# Creating 1st subnet 
resource "aws_subnet" "demosubnet1" {
  vpc_id                  = "${aws_vpc.demovpc.id}"
  cidr_block             = "${var.subnet1_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
tags = {
    Name = "Demo subnet 1"
  }
}
# Creating 2nd subnet 
resource "aws_subnet" "demosubnet2" {
  vpc_id                  = "${aws_vpc.demovpc.id}"
  cidr_block             = "${var.subnet2_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
tags = {
    Name = "Demo subnet 2"
  }
}

# Creating 3rd subnet 
resource "aws_subnet" "demosubnet3" {
  vpc_id                  = "${aws_vpc.demovpc.id}"
  cidr_block             = "${var.subnet3_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
tags = {
    Name = "Demo subnet 3"
  }
}

# Creating 4th subnet 
resource "aws_subnet" "demosubnet4" {
  vpc_id                  = "${aws_vpc.demovpc.id}"
  cidr_block             = "${var.subnet4_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
tags = {
    Name = "Demo subnet 4"
  }
}



#Creating Route Table
resource "aws_route_table" "publicroute" {
    vpc_id = "${aws_vpc.demovpc.id}"
route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.demogateway.id}"
    }
tags = {
        Name = "Route to internet"
    }
}

resource "aws_route_table" "privateroute" {
  vpc_id = "${aws_vpc.demovpc.id}"

  tags = {
    Name = "Private route"
  }
}


resource "aws_route_table_association" "rt1" {
    subnet_id = "${aws_subnet.demosubnet1.id}"
    route_table_id = "${aws_route_table.publicroute.id}"
}
resource "aws_route_table_association" "rt2" {
    subnet_id = "${aws_subnet.demosubnet2.id}"
    route_table_id = "${aws_route_table.privateroute.id}"
}

resource "aws_route_table_association" "rt3" {
    subnet_id = "${aws_subnet.demosubnet3.id}"
    route_table_id = "${aws_route_table.publicroute.id}"
}

resource "aws_route_table_association" "rt4" {
    subnet_id = "${aws_subnet.demosubnet4.id}"
    route_table_id = "${aws_route_table.privateroute.id}"
}

