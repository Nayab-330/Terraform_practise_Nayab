resource "aws_instance" "name" {
  ami = "ami-004f790b835b26145"
  instance_type = "t3.medium"  
  tags = {
    Name = "dev"
  }         
}

