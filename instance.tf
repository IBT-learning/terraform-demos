resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "ec2-vpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-subnet"
  }
}

resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "dev-igw"
  }
}

resource "aws_route_table" "my_public_rt"{
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "dev-rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id = aws_route_table.my_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.my_internet_gateway.id
}

resource "aws_route_table_association" "my_public_assoc"{
  subnet_id = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_public_rt.id
}


resource "aws_instance" "foo" {
  ami           = lookup(var.AMIS, var.AWS_REGION, "") # last parameter is the default value
  instance_type = "t2.micro"

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
