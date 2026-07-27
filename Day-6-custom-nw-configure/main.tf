#Creation of VPC with custom network configuration using Terraform
resource "aws_vpc" "dev_vpc" {
  cidr_block = "10.0.0.0/16"
    tags = {
        Name = "dev_vpc_terraform"
    }
}
#creation of subnet in the VPC with custom network configuration using Terraform
resource "aws_subnet" "dev_subnet" {
    vpc_id = aws_vpc.dev_vpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "dev_subnet_terraform"
    }
}
#creation of internet gateway in the VPC and attaching it with custom network configuration using Terraform
resource  "aws_internet_gateway" "dev_igw" {
    vpc_id = aws_vpc.dev_vpc.id
    tags = {
        Name = "dev_igw_terraform"
    }
}
#creation of route table in the VPC and attaching it to the IGW with custom network configuration using Terraform
resource "aws_route_table" "dev_route_table" {
    vpc_id = aws_vpc.dev_vpc.id
    tags = {
        Name = "dev_rt_terraform"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.dev_igw.id        
}
}
#Creation of route table association in the VPC and attaching it to the subnet with custom network configuration using Terraform
resource "aws_route_table_association" "dev_route_table_association" {
    subnet_id = aws_subnet.dev_subnet.id
    route_table_id = aws_route_table.dev_route_table.id
}
#creation of security group in the VPC and inbound and outbound rules with custom network configuration using Terraform
resource "aws_security_group" "dev_sg" {
    name = "dev_sg_terraform"
    description = "Allow SSH and HTTP inbound traffic"
    vpc_id = aws_vpc.dev_vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }   
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"  #-1 means all protocols 
        cidr_blocks = ["0.0.0.0/0"]
    }
}   
#Creation of EC2 instance in the VPC and attaching it to the subnet and security group with custom network configuration using Terraform
resource "aws_instance" "dev_instance" {
    ami = "ami-004f790b835b26145"  #give the AMI ID of the OS which you want to launch in the EC2 instance.
    instance_type = "t2.micro"
    subnet_id = aws_subnet.dev_subnet.id
    vpc_security_group_ids = [aws_security_group.dev_sg.id]
    tags = {
        Name = "dev_ec2_instance_terraform"
    }
}


resource "aws_subnet" "dev_subnet_private" {
    vpc_id = aws_vpc.dev_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"
    tags = {
        Name = "dev_subnet_private_terraform"
    }
}


resource "aws_nat_gateway" "dev_nat_gateway" {
  #allocation_id = aws_eip.dev_nat_eip.id
  #subnet_id     = aws_subnet.dev_subnet.id
  vpc_id = aws_vpc.dev_vpc.id
  availability_mode = "regional"
  tags = {
    Name = "dev_nat_gateway_terraform"
  }
  
}

resource "aws_route_table" "dev_route_table_private" {
    vpc_id = aws_vpc.dev_vpc.id
    tags = {
        Name = "dev_rt_private_terraform"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.dev_nat_gateway.id
    }
}

resource "aws_route_table_association" "dev_route_table_association_private" {
    subnet_id = aws_subnet.dev_subnet_private.id
    route_table_id = aws_route_table.dev_route_table_private.id
}

resource "aws_security_group" "dev_sg_private" {
    name = "dev_sg_private_terraform"
    description = "Allow SSH and HTTP inbound traffic"
    vpc_id = aws_vpc.dev_vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


resource "aws_instance" "dev_instance_private" {
    ami = "ami-004f790b835b26145"  #give the AMI ID of the OS which you want to launch in the EC2 instance.
    instance_type = "t2.micro"
    subnet_id = aws_subnet.dev_subnet_private.id
    vpc_security_group_ids = [aws_security_group.dev_sg_private.id]
    tags = {
        Name = "dev_ec2_instance_private_terraform"
    }
}