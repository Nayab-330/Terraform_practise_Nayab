resource "aws_instance" "name" {
  ami = "ami-004f790b835b26145"
  instance_type = "t3.medium"  
  tags = {
    Name = "dev"
  }         
}
resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "dev_vpc"
  }
}
