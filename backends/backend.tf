terraform {
  backend "s3" {
    bucket = "terraform-essencial-avera"
    key = "terraform-state/terraform.tfstate"
    region = "us-east-1"
    profile = "terraform3"
    #pode se utilizar para fazer um locking: dynamodb_table = ""
  }
}