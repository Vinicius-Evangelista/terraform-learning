resource "aws_security_group" "rds_sg" {
  name = "rds_sg"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [for ip in var.ips_liberados : "${ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

resource "random_password" "db_password" {
    length           = 16
    special          = true
}

resource "aws_db_instance" "postgres" {
  engine = "postgres"
  engine_version = "16.4"
  instance_class = "db.t3.micro"
  db_name = "vinidb"
  username = "vinicius"
  password = random_password.db_password.result
  parameter_group_name = "default.postgres16"
  skip_final_snapshot = true
  
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  tags = {
    Name = "rds"
  }
  
}