resource "aws_key_pair" "my_key" {
  key_name = "my_key"
  public_key = file("~/.ssh/id_rsa.pub")
}
#data source
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "foo" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  subnet_id = aws_subnet.my_subnet.id
  key_name = aws_key_pair.my_key.id

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.foo.private_ip} >> private_ips.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo sed -i -e 's/\r$//' /tmp/script.sh", # Remove the spurious CR characters.
      "sudo /tmp/script.sh",
    ]
  }
  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file("~/.ssh/id_rsa")
    timeout = "2m"
  }

  tags = {
    Name = "ibt-ec2"
  }
}

output "ip" {
  value = aws_instance.foo.private_ip
}

output "instance_state" {
  value = aws_instance.foo.instance_state
}

output "instance_arn" {
  value = aws_instance.foo.arn
}
