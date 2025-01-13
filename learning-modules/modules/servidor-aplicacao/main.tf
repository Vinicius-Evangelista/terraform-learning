resource "aws_security_group" "servidor_aplicacao_sg" {
  name = "servidor-aplicacao-sg"
  
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port = 443 
    to_port = 443 
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "production-sg"
  }
}

resource "aws_instance" "servidor_aplicacao_vms" {
  count = var.quantidade
  ami = "ami-0e86e20dae9224db8"
  instance_type = var.instance_type2 
  
  vpc_security_group_ids = [aws_security_group.servidor_aplicacao_sg.id]
  tags = {
    Name = "servidor-aplicacao-${count.index}"
  }
}