resource "aws_instance" "name" {
  ami = var.ami_id
  instance_type = var.instance_type
  tags = { Name = var.tags }

}



#terraform apply -var="ami_id=ami-004f790b835b26145" -var="instance_type=t3.micro" -var="tags=default-name"