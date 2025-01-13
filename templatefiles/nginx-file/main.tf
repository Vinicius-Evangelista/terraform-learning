variable "domain" {
  default = "example.com"
}

variable "locations" {
  default = [
    {
      path = "/",
      proxy_pass = "http://localhost:8080"
    },
    {
      path = "/api",
      proxy_pass = "http://localhost:8081"
    }
  ]
}

#################################
# EXEMPLO COM TEMPLATEFILE (TPL)#
#################################

resource "local_file" "nginx_config"{
  content = templatefile("${path.module}/nginx.conf.tpl", {
    domain = var.domain,
    locations = var.locations
  })
  filename = "${path.module}/nginx.conf"
}

############################
# EXEMPLO COM INTERPOLATION#
############################

variable "backend" {
  default = "localhost:8080"
}

locals {
  nginx_template = <<-EOF
    server {
        listen 80;
        server_name ${var.domain};
        
    }
    EOF
}

resource "local_file" "nginx_config_from_tpl" {
  content  = local.nginx_template
  filename = "${path.module}/nginx_from_tpl.conf"
}


######################################
# EXEMPLO USANDO APENAS FUNCOES DO TF#
######################################

locals {
  locations_config = join("\n", [
    for location in var.locations : <<EOF
    location ${location.path} {
          proxy_pass ${location.proxy_pass};
    }
    EOF
  ])
  nginx_template_exemplo_tf = <<-EOF
    server {
        listen 80;
        server_name ${var.domain};
        
    ${local.locations_config}
    }
    EOF
}

resource "local_file" "nginx_config_from_naive_tf" {
  content  = local.nginx_template_exemplo_tf
  filename = "${path.module}/nginx_from_tf_native_functions.conf"
}