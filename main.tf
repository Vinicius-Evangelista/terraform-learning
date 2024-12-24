terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.65.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}

data "aws_ami" "this" {
  most_recent = true
  owners = ["amazon"]
  
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
  
  filter {
    name = "name"
    values = ["0e86e20dae9224db8"]
  }
}

resource "aws_instance" "primeira_ec2" {
  ami = data.aws_ami.this.id
  instance_type = "t2.micro"
  tags = {
    Name = "segunda_ec2"
  }
}

resource "aws_instance" "segunda_ec2" {
  ami = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  tags = {
    Name = "segunda_ec2"
  }
}