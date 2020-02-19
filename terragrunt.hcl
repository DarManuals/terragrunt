remote_state {
  backend = "s3"
  config = {
    bucket = "terraform-tg"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region = "eu-central-1"
    encrypt = true
    dynamodb_table = "my-lock-table"
    profile = "my"
  }
}

inputs = {
  region = "eu-central-1"
  profile = "my"
  az_a = "eu-central-1a"
  az_b = "eu-central-1b"
  ec2_type = "t2.micro"
}