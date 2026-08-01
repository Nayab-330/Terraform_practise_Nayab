module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-s3-bucket-nayab-234565432345"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}

#source is https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest
#git repo : https://github.com/terraform-aws-modules/terraform-aws-s3-bucket 
#above the module is present. 