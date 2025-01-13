provider aws {
  region = "us-east-1"
  profile = "terraform3"
}

resource "aws_instance" "application_server" {
  ami = "ami-01816d07b1128cd2d"
  instance_type = "t2.micro"
}