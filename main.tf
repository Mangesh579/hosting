
provider "aws" {
  region = "us-east-1"
  profile = "dtc_class"
}

resource "aws_instance" "portfolio" {
  ami           = "ami-005fc0f236362e99f" 
  instance_type = "t2.medium"
  key_name      = "ikk" 
  
  vpc_security_group_ids = [aws_security_group.portfolio_sg.id]

  tags = {
    Name = "portfolio-ec2"
  }
}


resource "aws_security_group" "portfolio_sg" {
  name        = "portfolio-sg1"
  description = "Allow HTTP and SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

output "ec2_public_ip" {
  value = aws_instance.portfolio.public_ip
}
