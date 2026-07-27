variable "aws_vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "aws_vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = ""
}

variable "aws_subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = ""
}
variable "aws_subnet_az" {
  description = "The availability zone for the subnet"
  type        = string
  default     = ""
}

variable "aws_subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = ""
}
variable "aws_internet_gateway_name" {
  description = "The name of the internet gateway"
  type        = string
  default     = ""
}
variable "aws_rt_name" {
  description = "The name of the route table"
  type        = string
  default     = ""
}
variable "aws_rt_cidr_block" {
  description = "The CIDR block for the route table"
  type        = string
  default     = ""
}
variable "aws_rt_gateway_id" {
  description = "The ID of the gateway for the route table"
  type        = string
  default     = ""
}
variable "aws_route_table_association_subnet_id" {
  description = "The ID of the subnet for the route table association"
  type        = string
  default     = ""
}
variable "aws_subnet_association_route_table_id" {
  description = "The ID of the route table for the subnet association"
  type        = string
  default     = ""
}

#added variables for few resources in tfvars file.