provider "aws" {
  region = "us-east-1"
  profile = "terraform"
}

module "servidor_aplicacao_development" { 
  source = "./modules/servidor-aplicacao" 
  quantidade = 2
  instance_type2 = "t2.micro"
}

module "dev_database" { 
  source = "./modules/database" 
  ips_liberados = module.servidor_aplicacao_development.public_ip 
}

output "db_password" {
  value = module.dev_database.password
  sensitive = true
}