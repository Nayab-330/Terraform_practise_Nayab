terraform {
  backend "s3" {
    bucket = "dev-test-prod-nayab"  #give bucket name which you have created in AWS S3 to upload the tfstate file.
    key    = "terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
  }
}

