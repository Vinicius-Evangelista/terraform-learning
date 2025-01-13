provider tls {} 

resource "tls_private_key" "chave" {
  algorithm = "RSA"
  rsa_bits = 2048
}

resource "local_file" "k8s_secret" {
  content = templatefile("${path.module}/k8s_secret.yaml.tpl", {
    rsa_key_base64 = base64encode(tls_private_key.chave.private_key_pem)
  }) 
  filename = "${path.module}/k8s_secret.yaml"
}