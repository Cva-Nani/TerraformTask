resource "aws_instance" "web_app_instance" {
   ami                           = "ami-01fccab91b456acc2"
   instance_type                 = "t2.micro"
   key_name                    = "vijay"
   subnet_id                   = aws_subnet.webapp.id
   //subnet_id                     = aws_subnet.dmz.id
   security_groups             = [aws_security_group.webapp_sg.id]
   iam_instance_profile        = aws_iam_instance_profile.EC2_apache.name

   /*
   connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.keypair.private_key_pem
    host        = aws_instance.web_app_instance.public.id
  }
   */
  metadata_options {
    http_tokens = "required"
    http_endpoint = "enabled"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              
              sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
              sudo systemctl start amazon-ssm-agent
              sudo systemctl enable amazon-ssm-agent
              sudo yum install httpd -y
              sudo systemctl start httpd
              sudo systemctl enable httpd
              EOF
}
output "vpc_id" {
  value = aws_vpc.main.id
}

output "web_app_instance_id" {
  value = aws_instance.web_app_instance.id
}

output "web_app_instance_private_ip" {
  value = aws_instance.web_app_instance.private_ip
}
