terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.18.0"
    }
  }
}

provider "aws" {
  region=var.region
}

variable "region"{
  default = "ap-south-1"
}
variable "instance_type"{
  default = "t3.micro"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = "HelloWorld-EC2"
  }
}