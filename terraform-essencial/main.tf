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

provider "aws" {
  alias = "us-west-2"
  region = "us-east-2"
}

resource "aws_iam_user" "usuario_avera" {
  name = "Avera" 
}

resource "aws_iam_user_login_profile" "avera_user_password"{
  user = "Avera"  
  depends_on = [aws_iam_user.usuario_avera]
}

output "password_usuario_avera" {
  value = aws_iam_user_login_profile.avera_user_password.password
  sensitive = true
}

locals {
  ami = "ami-0b4624933067d393a"
  instance_type = var.instance_type
  tags = {
    Name1 = "ec1"
    Name2 = "ec2"
  }
}

resource "aws_instance" "ec2" {
  provider = aws.us-west-2
  count = 2
  ami = local.ami 
  instance_type = local.instance_type 
  tags = {
    Name = "EC${count.index}"
  }
}

resource "aws_instance" "production_vms" {
  # Parâmetro: create_before_destroy
  # Descrição: Cria um novo recurso antes de destruir o existente.
  # Quando usar: Ao evitar downtime ou interrupções.

  # Parâmetro: prevent_destroy
  # Descrição: Impede que o recurso seja destruído.
  # Quando usar: Proteger recursos críticos.

  # Parâmetro: ignore_changes
  # Descrição: Ignora alterações em atributos específicos.
  # Quando usar: Quando valores são gerenciados externamente.

  # Parâmetro: replace_triggered_by
  # Descrição: Recria o recurso se o recurso ou atributo especificado mudar.
  # Quando usar: Para dependências indiretas ou complexas. 
  
  
  lifecycle {
    create_before_destroy = true
    prevent_destroy = true
    ignore_changes = [tags]
  }
  
  for_each = var.instancias
  ami           = each.value.ami
  instance_type = each.value.instance_type
  tags = {
    Name = each.key
  }
}

output "public_ips" {
  value = aws_instance.production_vms["cache"].public_ip
}