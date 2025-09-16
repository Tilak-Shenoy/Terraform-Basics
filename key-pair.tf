resource "tls_private_key" "jenkins_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "jenkins_key_pair" {
  key_name   = "jenkins-1"
  public_key = tls_private_key.jenkins_key.public_key_openssh

  tags = {
    Name = "jenkins-key-pair"
  }
}

# Output the private key (be careful with this in production!)
output "private_key" {
  value     = tls_private_key.jenkins_key.private_key_pem
  sensitive = true
}

output "key_name" {
  value = aws_key_pair.jenkins_key_pair.key_name
}
