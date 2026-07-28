resource "aws_vpc" "dev_vpc" {
  cidr_block = "10.0.0.0/16"
    enable_dns_support   = true  #given this as RDS is public access mentioned below
    enable_dns_hostnames = true  #given this as RDS is public access mentioned below
  tags = {
    Name = "dev_vpc_terraform"
  }  
}

resource "aws_subnet" "dev_subnet1" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "dev_subnet_terraform1"
  }
} 

resource "aws_subnet" "dev_subnet2" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "dev_subnet_terraform2"
  }
}

resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "dev_igw_terraform"
  }
}

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

resource "aws_route_table_association" "dev_route_table_association1" {
  subnet_id      = aws_subnet.dev_subnet1.id
  route_table_id = aws_route_table.dev_route_table.id
}

resource "aws_route_table_association" "dev_route_table_association2" {
  subnet_id      = aws_subnet.dev_subnet2.id
  route_table_id = aws_route_table.dev_route_table.id
}

resource "aws_security_group" "dev_sg" {
  name        = "dev_sg_terraform"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.dev_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
  from_port   = 3306
  to_port     = 3306
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    }

}

resource "aws_db_subnet_group" "dev_subnet_group" {
  name       = "dev_subnet_group_terraform"
  subnet_ids = [aws_subnet.dev_subnet1.id, aws_subnet.dev_subnet2.id]
}

resource "aws_db_instance" "dev_db_instance" {
    allocated_storage    = 20
    storage_type         = "gp2"
    engine               = "mysql"
    engine_version       = "8.0"
    instance_class       = "db.t3.micro"
    identifier            = "devdb"
    username             = "admin"
    password             = "admin1234" #self-managed password
    #managed_master_user_password = true #enable this if you want to use AWS Secrets Manager for password management
    db_subnet_group_name = aws_db_subnet_group.dev_subnet_group.name
    vpc_security_group_ids = [aws_security_group.dev_sg.id]
    publicly_accessible = true #its false by default, so enabling it to true to make it public access.
    skip_final_snapshot   = true
    maintenance_window = "Mon:00:00-Mon:03:00"
    backup_retention_period = 7
    backup_window = "03:00-06:00"
}

#read replica of the above RDS instance
resource "aws_db_instance" "dev_db_read_replica" {
  identifier             = "devdb-read-replica"
  replicate_source_db    = aws_db_instance.dev_db_instance.identifier
  instance_class         = "db.t3.micro"
  publicly_accessible    = true #its false by default, so enabling it to true to make it public access.
  skip_final_snapshot    = true
  tags = {
    Name = "devdb-read-replica"
  }
}

