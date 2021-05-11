# Creating the instance with User Data.

resource "aws_instance" "myinstance" {
  ami = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  vpc_security_group_ids = ["sg-04781729ed7c037f3"]
  key_name = var.key_name

  iam_instance_profile = aws_iam_instance_profile.ec2-profile.name

  user_data = file("user_data.sh")
  
  tags = {
    "Name"  = "K8s-Management-Server"
  }
}