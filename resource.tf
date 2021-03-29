provider "aws" {
  region      =  "ap-northeast-1"
  #region = "us-east-1"
}

resource "aws_instance" "masa_tfe" {
  ami           = "ami-08847abae18baa040"
  instance_type = "t2.medium"
  # instance_type = "m4.4xlarge"
  key_name      = "masa"

  # My security setting
  security_groups = [aws_security_group.default.name]

  # Provisioner to store public dns name in file
  provisioner "local-exec" {
    command = "echo ${aws_instance.masa_tfe.public_dns} > public_dns.txt"
  }

  tags = {
    Name = "Sentinel demo"
    Owner = "Masa"
    TTL = "1"
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

