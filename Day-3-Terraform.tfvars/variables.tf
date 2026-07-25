variable "ami_id" {
  description = "ami_id of the instance"
  type = string 
  default = ""
}


variable "instance_type" {
  description = "instance_type of the server"
  type = string
  default = ""
}


variable "tags" {
  description = "name of the instance"
  type = string
  default = ""
}



variable "bucket_name" {
  type = string
}


