terraform {
  backend "s3" {
    bucket         = "yomex-terraform-state-bucket"  
    key            = "credpal-app/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-lock-table-yomex"      
    encrypt        = true                         
  }
}