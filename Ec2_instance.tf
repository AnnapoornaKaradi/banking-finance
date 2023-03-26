resource "aws_instance" "Test-Server" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.small"
  key_name               = "KeyPair"
  vpc_security_group_ids = ["sg-042dc4a8470874afb"]
  tags = {
    Name = "Test-Server"
  }
}

