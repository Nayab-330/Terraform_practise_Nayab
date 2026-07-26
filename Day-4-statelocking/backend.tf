terraform {
  backend "s3" {
    bucket = "dev-test-prod-nayab"  #give bucket name which you have created in AWS S3 to upload the tfstate file.
    key    = "terraform.tfstate"
    region = "us-east-1"
    #use_lockfile = true  #if terraform version is >1.10
    dynamodb_table = "terraform-state-locking" #if terraform version is <1.10. give the name of the dynamodb table which you have created in AWS DynamoDB to lock the state file.
  }
}

