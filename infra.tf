terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
        version = "5.79.0"
    }
  }

# creating a backend to manage state files.
# using a backend to prevent secrets from being commited to git repo. 
  cloud {
    organization = "pjferguson-dev"
    workspaces {
      name = "app-dev"
    }
  }
}





provider "aws" {

}

resource "aws_vpc" "cloud-sec" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
    vpc_id = aws_vpc.cloud-sec.id
    cidr_block = "10.0.1.0/24"  
    tags = {
        Name = "Main-subnet"
    }

}
resource "aws_route_table" "routes" {
  vpc_id = aws_vpc.cloud-sec.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default-gw.id
  }

}
resource "aws_route_table_association" "public_subnet" {
  subnet_id = aws_subnet.main.id
  route_table_id = aws_route_table.routes.id
}

resource "aws_security_group" "default-sec" {
    description = "Creating security group for AWS project environment."
    vpc_id = aws_vpc.cloud-sec.id

}
# creating a rule to allow outbound traffic for instances within VPC. 
resource "aws_security_group_rule" "allow_outbound_traffic" {
    type = "egress"
    security_group_id = aws_security_group.default-sec.id
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"

}
# This should never be a rule in a production environment. 
resource "aws_security_group_rule" "allow_ssh" {
    type = "ingress"
    security_group_id = aws_security_group.default-sec.id
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"

}

resource "aws_internet_gateway" "default-gw" {
  vpc_id = aws_vpc.cloud-sec.id
}



resource "aws_key_pair" "management" {
    key_name = "netflix"
    public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAv0ROfSCA6etxl3HWuxnMeS0v9Hp/tyVNwtDNDNr7Xh promyseferguson@MacBook-Pro.local"
}

resource "aws_instance" "netflix-machine" {
    ami = "ami-05803413c51f242b7"
    instance_type = "t2.micro"
    key_name = aws_key_pair.management.key_name
    subnet_id = aws_subnet.main.id
    associate_public_ip_address = true
    vpc_security_group_ids = ["${aws_security_group.default-sec.id}"]
    user_data = file("${path.module}/script.sh")
      
    
}

output "machine-ip" {
      value = aws_instance.netflix-machine.public_ip
        }