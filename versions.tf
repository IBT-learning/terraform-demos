terraform {
  required_version = ">= 0.12"
}

terraform {
    backend "s3" {
    bucket = "<CREATE_A_BUCKET_AND_UPDATE_NAME_HERE"
    key    = "path/to/my/key"
    region = "us-east-1"
    access_key = "YOUR_ACCESS_KEY"
    secret_key = "YOUR_SECRET_KEY"
  }
}
