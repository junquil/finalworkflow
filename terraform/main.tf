provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "flask_app" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2023 AMI (update if needed)
  instance_type = "t2.micro"
  key_name      = "my-key"

  tags = {
    Name = "flask-app-instance"
  }

  provisioner "file" {
    source      = "../ansible"
    destination = "/home/ec2-user/ansible"
  }
}

output "ec2_public_ip" {
  value = aws_instance.flask_app.public_ip
}
