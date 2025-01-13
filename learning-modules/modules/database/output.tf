output "password" {
  sensitive = true
  value = random_password.db_password.result
}