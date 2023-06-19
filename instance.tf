module "dev-ec2" {
  source = "./ec2"
}

output "dev-ip" {
  value = module.dev-ec2.ip_address_instance1
}