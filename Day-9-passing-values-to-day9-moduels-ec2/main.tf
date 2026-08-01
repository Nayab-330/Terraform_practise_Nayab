module "dev" {
    #source = "../Day-9-Modules-ec2"   #it is form local path
    source = "github.com/Nayab-330/1030-terraform-practice.git/Day-9-Modules-ec2"  #it isfrom github remote path
    ami_id = "ami-02b64aa047cb5edf5"
    instance_type = "t2.medium"
    tags = "MyTerraformInstance"

}