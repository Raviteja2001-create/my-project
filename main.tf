provider "aws" {
    region = "ap-south-1"
  
}

resource "aws_vpc" "amazon_vpc" {
    cidr_block = "10.0.0.0/16"

  
}
resource "aws_subnet" "amazon_subnet" {
    vpc_id = aws_vpc.amazon_vpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true

}

resource "aws_subnet" "amazon_subnet-1" {
    vpc_id = aws_vpc.amazon_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1b"
    map_public_ip_on_launch = true

}

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.amazon_vpc.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.amazon_vpc.id

route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "a" {
    subnet_id = aws_subnet.amazon_subnet.id
    route_table_id = aws_route_table.rt.id
}
    
resource "aws_route_table_association" "b" {
    subnet_id = aws_subnet.amazon_subnet-1.id
    route_table_id = aws_route_table.rt.id
  
}

resource "aws_security_group" "sgw" {
  name        = "sgw"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.amazon_vpc.id

  
}

resource "aws_vpc_security_group_ingress_rule" "allow_inbound_rule-1" {
  security_group_id = aws_security_group.sgw.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_inbound_rule-2" {
  security_group_id = aws_security_group.sgw.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
resource "aws_vpc_security_group_egress_rule" "allow_outbound_rule" {

  security_group_id = aws_security_group.sgw.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}  
  resource "aws_s3_bucket" "s3_bucket" {
    bucket = "ravitejaterraform-s3-abc"

}


resource "aws_instance" "my_instance"{
ami = "ami-051a31ab2f4d498f5"
instance_type = "t2.micro"
subnet_id = aws_subnet.amazon_subnet.id
vpc_security_group_ids= [aws_security_group.sgw.id]
  
}

resource "aws_instance" "dev_instance"{
ami = "ami-051a31ab2f4d498f5"
instance_type = "t2.micro"
subnet_id = aws_subnet.amazon_subnet-1.id
vpc_security_group_ids= [aws_security_group.sgw.id]

}