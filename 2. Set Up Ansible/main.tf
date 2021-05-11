# Creating the instance with User Data.

resource "aws_instance" "myinstance" {
  ami = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  vpc_security_group_ids = ["ansible-sg"]
  key_name = var.key_name

  user_data = file("user_data.sh")
  
  tags = {
    "Name"  = "Ansible-Server"
  }
}