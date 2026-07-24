variable "cidr_block" {
  description = "CIDR block of vpc 1"
  type = string
  default = "" 
}

variable "tag" {
    description = "tag of the vpc1"
  type = string
  default = ""

}


variable "tag2" {
    description = "tag of the vpc2"
  type = string
  default = ""

}

variable "cidr_block_2" {
  description = "CIDR block of vpc 2"
  type = string
  default = ""
}

variable "subnet_1" {
  description = "subnet 1 cidr"
  type = string
  default = ""
}

variable "tag_subnet" {
    description = "tag of the subnet1"
  type = string
  default = "nayab"

}   