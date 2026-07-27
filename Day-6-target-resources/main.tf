#Creation of VPC with custom network configuration using Terraform
resource "aws_vpc" "dev_target_vpc" {
  cidr_block = "10.0.0.0/16"
    tags = {
        Name = "dev_vpc_terraform"
    }
}
#creation of subnet in the VPC with custom network configuration using Terraform
resource "aws_subnet" "dev_target_subnet" {
    vpc_id = aws_vpc.dev_target_vpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "dev_subnet_terraform"
    }
}




#db rds not able to create, need to check next day
resource "aws_database_instance" "dev_target_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "admin"
  password             = "Cloud123"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  availability_zone    = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.dev_target_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.dev_target_db_subnet_group.name
}





#terraform plan --target=aws_vpc.dev_target_vpc