provider "aws" {
  region = "ap-south-1"
}


data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}


resource "aws_instance" "web" {
  ami           = "ami-019715e0d74f695be"
  instance_type = "t3.micro"

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y docker.io docker-compose

              sudo systemctl start docker
              sudo systemctl enable docker

              git clone https://github.com/aman-sutar/devops-assessment.git
              cd devops-assessment

              sudo docker-compose up --build
              EOF

  subnet_id = data.aws_subnets.default.ids[0]

  associate_public_ip_address = true


  vpc_security_group_ids = [
    aws_security_group.web.id
  ]

  tags = {
    Name = "devops-assessment"
  }
}

resource "aws_security_group" "web" {
  name = "devops-assessment-sg"
   vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   # Port 8000
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 3000
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
