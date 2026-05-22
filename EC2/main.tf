provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ram" {
  most_recent = true
  owners = [ "amazon" ]

  filter {
    name = "architecture"
    values = ["x86_64"]
}
  filter {
    name = "name"
    values = ["al2023-ami-2023*"]
    }
  }

resource "aws_instance" "my_ec2" {
  ami           = data.aws_ami.ram.id   # Amazon Linux (example)
  instance_type = "t3.small"
  monitoring = false

  vpc_security_group_ids = [aws_security_group.my_sg.id]

  tags = {
    Name = "Terraform-EC2"
    Environment="Development"
  }
}




