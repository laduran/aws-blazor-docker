provider "aws" {
  region = "us-west-2"
}


## Do I even need this if I am using ECS to run the containers?
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

# something to store the terraform state file?
# S3 bucket for storing terraform state file
# DynamoDB table for locking state file?

# ECR?
# Fargate cluster (also ECS cluster)
# VPC
# Subnet
# Route Table
# Load balancer?
# RDS for database configured to PostgreSQL instace.
# S3 bucket for storing static files

# Route 53 settings for domain  <-- This doesn't need to be managed through Terraform

