resource "aws_instance" "name" {
  ami = "ami-004f790b835b26145"
  instance_type = "t2.micro"  
  tags = {
    Name = "dev-windows"
  }         
}

