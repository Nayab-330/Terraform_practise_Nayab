resource "aws_instance" "name" {
  ami = "ami-0bdc7d025135d7b41"
  instance_type = "t2.micro"
  tags = {
    Name = "server-new-lifecycle"
  }

lifecycle {
    create_before_destroy = true # 1st create and then destroy
  } 

  # lifecycle {
  #   ignore_changes = ["tags"] # ignore changes in tags done manually in AWS console
  #   # (e.g. changing tag from server-lifecycle to server99-lifecycle in console won't be reflected in terraform plan)
  # }

# lifecycle {
#    prevent_destroy = true # prevent accidental deletion of the resource, if you run terraform destroy -auto-approve alos, it will not delete the resource
#   } 

}