variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

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

