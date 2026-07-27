output "aws_instance_public_ip" {
  value = aws_instance.dev_instance.public_ip
}
output "aws_instance_private_ip" {
  value = aws_instance.dev_instance.private_ip
}
output "aws_instance_id" {
  value = aws_instance.dev_instance.id
}
output "aws_instance_availability_zone" {
  value = aws_instance.dev_instance.availability_zone
}
output "aws_instance_type" {
  value = aws_instance.dev_instance.instance_type
}
output "aws_instance_ami" {
  value = aws_instance.dev_instance.ami
}
output "aws_instance_vpc_security_group_ids" {
  value = aws_instance.dev_instance.vpc_security_group_ids
}
output "aws_vpc_id" {
  value = aws_vpc.dev_vpc.id
}


output "aws_subnet_id" {
  value = aws_subnet.dev_subnet.id
}


output "aws_instance_private_public_ip" {
  value = aws_instance.dev_instance_private.public_ip
}

output "aws_instance_private_private_ip" {
  value = aws_instance.dev_instance_private.private_ip
}   
output "aws_instance_private_id" {
  value = aws_instance.dev_instance_private.ami
}
output "aws_instance_private_availability_zone" {
  value = aws_instance.dev_instance_private.availability_zone
}   
output "aws_instance_private_type" {
  value = aws_instance.dev_instance_private.instance_type
}
output "aws_instance_private_vpc_security_group_ids" {
  value = aws_instance.dev_instance_private.vpc_security_group_ids
}
output "aws_subnet_private_id" {
  value = aws_subnet.dev_subnet_private.id
}
output "aws_nat_gateway_id" {
  value = aws_nat_gateway.dev_nat_gateway.id
}
output "aws_route_vpc_id" {
  value = aws_route_table.dev_route_table_private.vpc_id
}