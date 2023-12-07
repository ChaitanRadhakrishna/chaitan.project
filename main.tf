provider "aws"  {
    region = "us-east-2"
}

 

resource "aws_instance" "test-server1" {
 ami = "ami-09f85f3aaae282910"
 instance_type = "t2.large"
 key_name = "ohio.key"



 user_data = <<-EOF
              #!/bin/bash
              chmod 700 /home/ec2-user/.ssh
              sudo ssh-keygen -t rsa -b 2048 -f /home/ec2-user/.ssh/id_rsa -q -N ''
              chown -R ec2-user:ec2-user /home/ec2-user/.ssh
              EOF

 tags = {
 Name = "Jenkins-master"
  }


}


resource "aws_instance" "c8" {
 ami = "ami-09f85f3aaae282910"
 instance_type = "t2.micro"
 key_name = "ohio.key"
 user_data     = <<-EOF
                 #!/bin/bash
                 sudo hostnamectl set-hostname c8.local
                 EOF
 tags = {
 Name = "c8.local"
  }


}

resource "aws_instance" "u21" {
 ami = "ami-07b36ea9852e986ad"
 instance_type = "t2.micro"
 key_name = "ohio.key"
 user_data     = <<-EOF
                 #!/bin/bash
                 sudo hostnamectl set-hostname u21.local
                 EOF
 
 tags = {
 Name = "u21.local"
  }

}

output "frontend" {
  value = aws_instance.c8.public_ip
}

output "backend" {
  value = aws_instance.u21.public_ip
}