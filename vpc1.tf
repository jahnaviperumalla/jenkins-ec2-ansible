variable "aws_region" {
	default = "us-east-1"
}

variable "vpc_cidr" {
	default = "10.20.0.0/16"
}

variable "public_subnets_cidr" {
	type = list
	default = $public_cidr
}

variable "private_subnets_cidr" {
	type = list
	default = $private_cidr
}

variable "azs" {
	type = list
	default = ["us-east-1a", "us-east-1b"]
}


# VPC
resource "aws_vpc" "terra_vpc" {
  cidr_block       = var.vpc_cidr
  tags = {
    Name = "vpc-name"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "terra_igw" {
  vpc_id = aws_vpc.terra_vpc.id
  tags = {
    Name = "igw-name"
  }
}

# Subnets : public
resource "aws_subnet" "public" {
  count = length(var.public_subnets_cidr)
  vpc_id = aws_vpc.terra_vpc.id
  cidr_block = element(var.public_subnets_cidr,count.index)
  availability_zone = element(var.azs,count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-${count.index+1}"
  }
}

# Route table: attach Internet Gateway 
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.terra_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra_igw.id
  }
  tags = {
    Name = "publicRouteTable"
  }
}

# Route table association with public subnets
resource "aws_route_table_association" "a" {
  count = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public.*.id,count.index)
  route_table_id = aws_route_table.public_rt.id
}


# Creating an Elastic IP for the NAT Gateway!
resource "aws_eip" "nat-gateway-eip" {
  vpc = true
}

# Creating a NAT Gateway!
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat-gateway-eip.id
  subnet_id = aws_subnet.public[0].id
  tags = {
    Name = "nat-name"
  }
}

# Subnets : private
resource "aws_subnet" "private" {
  count = length(var.private_subnets_cidr)
  vpc_id = aws_vpc.terra_vpc.id
  cidr_block = element(var.private_subnets_cidr,count.index)
  availability_zone = element(var.azs,count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "Private-Subnet-${count.index+1}"
  }
}


resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.terra_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw.id
  }
  tags = {
    Name = "privateRouteTable"
  }
}


# Route table association with private subnets
resource "aws_route_table_association" "b" {
  count = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private.*.id,count.index)
  route_table_id = aws_route_table.private_rt.id
}


