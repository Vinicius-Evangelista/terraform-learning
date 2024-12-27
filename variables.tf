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