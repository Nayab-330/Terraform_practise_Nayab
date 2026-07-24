resource "aws_vpc" "test" {
  cidr_block = var.cidr_block
  tags = { Name = var.tag } 
}

resource "aws_vpc" "dev" {
  cidr_block = var.cidr_block_2
  tags = { Name = var.tag2 }
}


resource "aws_subnet" "test" {
  vpc_id = aws_vpc.test.id
  cidr_block = var.subnet_1             
  tags = { Name = var.tag_subnet } 
}
 
