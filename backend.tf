terraform {
  backend "s3" {
    bucket = "terraform-rollback"
    key    = "terraform-demo/terraform.tfstate"
    region = "ap-south-1"
  }
}
