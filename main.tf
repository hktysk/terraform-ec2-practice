terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "hkt"
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-042e8287309f5df03"
  instance_type = "t2.micro"
  key_name = aws_key_pair.auth.id
  vpc_security_group_ids = [aws_security_group.default.id]

  tags = {
    Name = "ExampleInstanceAAAAA"
  }
}

resource "aws_key_pair" "auth" {
  key_name = "example"
  public_key = file("./id_rsa.pub")
}

resource "aws_security_group" "default" {
  name = "example_security_group"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
