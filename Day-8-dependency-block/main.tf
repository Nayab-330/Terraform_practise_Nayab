resource "aws_vpc" "dev_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "dev_vpc_terraform"
   
  }
}



resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name-nayab12345432" # Change this to a unique name
   depends_on = [aws_vpc.dev_vpc] # Ensure the VPC is created before the S3 bucket
}