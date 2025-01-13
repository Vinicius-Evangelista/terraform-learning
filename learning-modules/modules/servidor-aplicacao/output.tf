output "public_ip" {
  value = aws_instance.servidor_aplicacao_vms.*.public_ip
}