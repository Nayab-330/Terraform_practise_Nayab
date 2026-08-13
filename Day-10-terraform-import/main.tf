resource "aws_instance" "name" {
     ami           = "ami-0bdc7d025135d7b49"
     instance_type = "t2.medium"
    tags = {
        Name = "server-1"
    }
  }

  resource "aws_s3_bucket" "name" {
    bucket = "nayab-nayab-nayab123"
  }

  resource "aws_s3_bucket_versioning" "name" {
    bucket = "nayab-nayab-nayab123"
    versioning_configuration {
      status = "Enabled"
    }
  }