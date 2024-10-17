provider "aws" {
  region = "ap-south-1"  # Update this as needed
}
 
resource "aws_instance" "web" {
  ami           = "ami-04a37924ffe27da53"  # Replace with a valid AMI ID
  instance_type = "t2.micro"
 
  tags = {
    Name = "TerraformDemo"
  }
}
