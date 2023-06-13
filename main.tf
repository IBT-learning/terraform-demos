resource "aws_instance" "aws_instance1" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name = "test-demo1"
  }
}

resource "aws_instance" "aws_instance2" {
  ami           = "ami-06b94666"
  instance_type = "t2.micro"

  tags = {
    Name = "test-demo2"
  }
}

output "ip_address_instance1" {
  value = aws_instance.aws_instance1.private_ip
}