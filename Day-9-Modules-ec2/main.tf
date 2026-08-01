resource "aws_instance" "my_tf_instance" {
    ami = var.ami_id 
    instance_type = var.instance_type
    tags = {
        Name = var.tags
    }
}