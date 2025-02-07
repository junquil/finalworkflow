provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "flask_app" {
  ami           = "ami-0c614dee691cbbf37" # Amazon Linux 2023 AMI (update if needed)
  instance_type = "t2.micro"
  key_name      = "devops_jun"

  tags = {
    Name = "flask-app-instance"
  }
  # 🔹 Add SSH connection details
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = filebase64(var.private_key_path) # ✅ Fix: Use base64 function
    host        = self.public_ip
  }
}

provisioner "file" {
    source      = "../ansible"
    destination = "/home/ec2-user/ansible"
  }

output "ec2_public_ip" {
  value = aws_instance.flask_app.public_ip
}
