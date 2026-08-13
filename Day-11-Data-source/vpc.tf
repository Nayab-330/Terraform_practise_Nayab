resource "aws_vpc" "custnw" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Nayab-vpc"
  }
  
}

resource "aws_internet_gateway" "custnw" {
  vpc_id = aws_vpc.custnw.id
  tags = {
    Name = "Nayab-igw"
  }
}

resource "aws_subnet" "custnw"  {
  vpc_id     = aws_vpc.custnw.id
  cidr_block = "10.0.0.0/24"
    tags = {
        Name = "Nayab-subnet"
    }   
}



resource "aws_route_table" "custnw" {
  vpc_id = aws_vpc.custnw.id
  tags = {
    Name = "Nayab-rt"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custnw.id
  }     
}


resource "aws_route_table_association" "custnw" {
  subnet_id      = aws_subnet.custnw.id
  route_table_id = aws_route_table.custnw.id
}

resource "aws_security_group" "custnw" {
  name        = "Nayab-sg"
  description = "Allow TLS inbound traffic and SSH and HTTP"
  vpc_id      = aws_vpc.custnw.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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

