# Defining Public Key
variable "public_key" {
  default = "tests.pub"
}
# Defining Private Key
variable "private_key" {
  default = "tests.pem"
}
# Definign Key Name for connection
variable "key_name" {
  default = "tests"
  description = "Name of AWS key pair"
}
# Defining CIDR Block for VPC
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
# Defining CIDR Block for Subnet
variable "subnet1_cidr" {
  default = "10.0.1.0/24"
}
# Defining CIDR Block for 2d Subnet
variable "subnet2_cidr" {
  default = "10.0.2.0/24"
}
# Defining CIDR Block for 3d Subnet
variable "subnet3_cidr" {
  default = "10.0.3.0/24"
}

# Defining CIDR Block for 4t Subnet
variable "subnet4_cidr" {
  default = "10.0.4.0/24"
}

variable "user_name_for_s3readonlyacess" {
  default = "user1"
}

variable "user_name_for_s3fullacess" {
  default = "user2"
}

variable "ami" {
  default = "ami-017fecd1353bcc96e"
}

variable "instance-type" {
  default = "t2.micro"
}

variable "keyname" {
  default = "harish-neworegon"
}

variable "security-group" {
  default = "launch-wizard-6"
}

variable "accesskey" {
  default = ""
}

variable "secretkey" {
  default = ""
}


