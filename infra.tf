terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>5.0"
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
    region = "us-east-2"
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

resource "aws_security_group" "default-sec" {
    description = "Creating security group for AWS project environment."
    vpc_id = aws_vpc.cloud-sec.id

}
# creating a rule to allow outbound traffic for instances within VPC. 
resource "aws_vpc_security_group_egress_rule" "allow_outbound_traffic" {
    security_group_id = aws_security_group.default-sec.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"

}
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
    security_group_id = aws_security_group.default-sec.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 22
    ip_protocol = "tcp"
    to_port = 22

}

resource "aws_key_pair" "netflix-key" {
    public_key = pathexpand("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "netflix-machine" {
    ami = "ami-05803413c51f242b7"
    instance_type = "t2.micro"
    key_name = aws_key_pair.netflix-key.id
    subnet_id = aws_subnet.main.id
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.default-sec.id]
    user_data <<-EOF
        #!/bin/bash
        file("${path.module}/script.sh")
        echo "Let's start docker!"
        docker build --build-arg TMDB_V3_API_EKY="${var.key}" -t netflix .

}

 output "machine-ip" {
        value = aws_instance.netflix-machine.public_ip
    }