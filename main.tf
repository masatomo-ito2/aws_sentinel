provider "aws" {
  region = var.region
}


resource "aws_instance" "masa_tfe" {
  ami             = "ami-08847abae18baa040"
  instance_type   = var.instance_type
  key_name        = "masa"
  security_groups = [aws_security_group.default.name]
  tags = {
    Name  = "Sentinel demo"
    Owner = "Masa"
    Org   = "HashiCorp"
    TTL   = "1"
  }
}

resource "aws_security_group" "default" {
  name        = "terraform_security_group"
  description = "Allow access to SSH port"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Sentinel demo"
  }
}

