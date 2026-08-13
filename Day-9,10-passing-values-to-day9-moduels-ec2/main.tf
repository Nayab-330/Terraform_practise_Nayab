module "dev" {
    #source = "../Day-9-Modules-ec2"   #it is form local path
    source = "github.com/Nayab-330/1030-terraform-practice.git/Day-9-Modules-ec2"  #it isfrom github remote path
    ami_id = var.ami_id
    instance_type = var.instance_type
    tags = var.tags

}