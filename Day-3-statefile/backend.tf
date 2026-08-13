terraform {
  backend "s3" {
    bucket = "nayabnayab-tfstate"  #give bucket name which you have created in AWS S3 to upload the tfstate file.
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
