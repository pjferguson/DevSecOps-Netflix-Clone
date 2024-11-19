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
    user_data = <<-EOF
        #!/bin/bash
        file("${path.module}/script.sh")
        echo "Let's start docker!"
        docker build --build-arg TMDB_V3_API_EKY="${var.key}" -t netflix .
        api_key="${var.key}"
        DOCKERUSER="${var.dockerus}"
        DOCKER_ACCESS_TOKEN="${var.access}"
        # Let's get this new container scanned
        image_id=$(docker ps --format "{{.Image}}" | head -n 1)
        trivy image $image_id
        # installation of python3, which will be used to run python script that will grab the sonarqube token. 
        sudo apt-get install python3.10
        # installation of postgresql
        sudo apt install postgresql
        sudo -i -u postgres
        createuser sonar
        db=$(createdb sonar)
        psql -d $db -c "ALTER USER sonar WITH ENCRYPTED PASSWORD '${var.sonarpw}';
        GRANT ALL PRIVILEGES ON DATABASE sonar TO sonar
        GRANT ALL ON SCHEMA public TO sonar;
        GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO sonar;
        GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO sonar;
        GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO sonar;
        GRANT USAGE ON SCHEMA public TO sonar;
        GRANT CREATE ON SCHEMA public TO sonar;"
        exit
        exit
        echo "local   sonar           sonar                                   scram-sha-256" >> /etc/postgresql/16/main/pg_hba.conf"
        file("${path.module}/sonartoken.py)
        file("${path.module}/sonar.sh")
        EOF


}

 output "machine-ip" {
        value = aws_instance.netflix-machine.public_ip
    }