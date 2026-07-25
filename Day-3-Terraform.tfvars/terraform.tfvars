ami_id = "ami-004f790b835b26145"
instance_type = "t3.micro"
tags = "default-name"
#bucket_name = "nayab8247644754345676"

#my tfvas name is dev.tfvars

# tfvars file name should be terraform.tfvars fro terraform to automatically pickup 

# -var-file need to give if u have diffferent name 


#while runtime also we can pass variables


#terraform -appy -var="ami_id = ami-004f790b835b26145" -var="instance_type = t3.micro"  -var="tags = default-name"