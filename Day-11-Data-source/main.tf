# Data source in Terraform is used to fetch data from existing resources or external sources. It allows you to reference information about resources that are not managed by your Terraform configuration.
# Data sources are useful when you need to retrieve information about existing infrastructure, such as AMI IDs, VPC IDs, or other resource attributes, without creating or managing those resources directly.
# Data sources can be used to reference existing resources in your Terraform configuration, enabling you to build more dynamic and flexible infrastructure.
# Data sources can also be used to retrieve information from external systems, such as cloud providers, APIs, or other data sources, allowing you to integrate external data into your Terraform workflows.
# Data sources are read-only and do not create or modify resources. They are primarily used for retrieving information that can be used in resource definitions, outputs, or other parts of your Terraform configuration.
# Data sources can be defined using the "data" block in Terraform, specifying the type of data source and any required parameters. The retrieved data can then be accessed using interpolation syntax or referenced in other resource definitions.
# Data sources can be combined with other Terraform features, such as variables, outputs, and modules, to create more modular and reusable infrastructure code. They allow you to leverage existing resources and data in your Terraform configurations, making it easier to manage and maintain your infrastructure over time.
# Data sources can also be used to retrieve information about resources that are managed by other Terraform configurations or modules, allowing you to reference and utilize those resources in your own configuration without duplicating their definitions.


data "aws_subnet" "Datablock_subnet" {
    id = "subnet-079f2faebbc09ce6c"
    # filter {
#     name   = "tag:Name"
#     values = ["Nayab-subnet"]
#   }
}


data "aws_security_group" "existing_sg" {
    id = "sg-018c3c38ec5b80bd3"
#   filter {
#     name   = "group-name"
#     values = ["Nayab-sg"]
#   }
}



resource "aws_instance" "name" {
  subnet_id = data.aws_subnet.Datablock_subnet.id
  security_groups = [data.aws_security_group.existing_sg.id]
  ami = "ami-0bdc7d025135d7b49"
  instance_type = "t2.micro"
  tags = {
    Name = "Nayab-ec2"
  }
}

