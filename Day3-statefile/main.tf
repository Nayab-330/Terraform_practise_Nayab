resource "aws_instance" "name" {
  ami           = "ami-004f790b835b26145"
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.name.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  tags = {
    Name = "latest-name"
  }
}


resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "dev_vpc"
  }
}

resource "aws_subnet" "name" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = "10.0.0.0/24"
  tags = {
    Name = "dev_subnet"
  } 

}

resource "aws_security_group" "my_security_group" {
  name        = "my_security_group"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.name.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
} 
}