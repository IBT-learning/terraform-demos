variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-00c39f71452c08778"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-0d729a60"
  }
}


variable "PATH_TO_PRIVATE_KEY" {
  default = "id_rsa"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "id_rsa.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ec2-user"
}
