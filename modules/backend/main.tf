data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "web_sg" {
  name   = "web_sg-${var.name}"
  vpc_id = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.ec2_type
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.web_sg.id]
  tags = merge(var.custom_tags, {
    Name = "Web-${var.name}"
  })
}

variable "profile" {}
variable "region" {}
variable "vpc_id" {}
variable "subnet_id" {}
variable "ec2_type" {}
variable "name" {
  description = "Name which to use as a prefix for resources"
}
variable "custom_tags" {
  description = "Custom tags to set on the Instances in the ASG"
  type        = map(string)
  default = {
    CustomTag = "custom"
  }
}