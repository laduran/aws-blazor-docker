provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "web_server" {
  ami               = "ami-04a81a99f5ec58529"
  instance_type     = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data         = <<-EOF
  #!/bin/bash
  echo "Hello, World" > index.html
  nohup busybox httpd -f -p 8080 &
  EOF

  tags = {
    Name = "web-server"
  }
}