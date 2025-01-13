variable "most_recent_ami" {
  description = "Selecione a AMI mais recente"
  type        = bool 
}

variable "instance_type" {
  description = "Tipo da EC2"
  type        = string  
}

variable "core_count" {
  description = "Número de cores"
  type        =  number 
}

variable "list_arqchitecture" {
  description = "Lista de arquiteturas"
  type        = list(string)
}

variable "instancias" {
  type = map(object({
    ami = string
    instance_type = string 
  }))
  default = {
    "web" = {
      ami = "ami-01816d07b1128cd2d"
      instance_type = "t2.micro"
    },
    "db" = {
      ami = "ami-01816d07b1128cd2d"
      instance_type = "t2.micro" 
    },
    "cache" = {
      ami = "ami-01816d07b1128cd2d"
      instance_type = "t2.micro" 
    }
  }
}
