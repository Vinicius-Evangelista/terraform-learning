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
}

resource "aws_iam_user" "usuario_avera" {
  name = "Avera" 
}

resource "aws_iam_user_login_profile" "avera_user_password"{
  user = aws_iam_user.usuario_avera.name
}

output "password_usuario_avera" {
  value = aws_iam_user_login_profile.avera_user_password.password
  sensitive = true
}

locals {
  ami = "ami-0e86e20dae9224db8"
  instance_type = var.instance_type
  tags = {
    Name1 = "ec1"
    Name2 = "ec2"
  }
}

resource "aws_instance" "primeira_ec2" {
  ami = local.ami 
  instance_type = local.instance_type 
  tags = {
    Name = local.tags.Name1 
  }
}

resource "aws_instance" "segunda_ec2" {
  ami = local.ami
  instance_type = local.instance_type
  tags = {
    Name = local.tags.Name2
  }
}