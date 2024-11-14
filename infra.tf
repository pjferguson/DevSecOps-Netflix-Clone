terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~>5.0"
      }
    }
    
}

provider "aws" {
    region = "us-east-2a"
}

resource "aws_vpc" "cloud-sec" {
    cidr_blocks = ["10.0.0.0/16"]
}

resource "aws_subnet" "main" {
    vpc_id = aws_vpc.cloud-sec.id
    cidr_block = [""]    
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


resource "aws_instance" "netflix-machine" {
    subnet_id = aws_subnet.main.id
}