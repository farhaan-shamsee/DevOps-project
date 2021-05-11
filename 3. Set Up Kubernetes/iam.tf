#Step 5: Creating IAM Role:
# The following create a policy and a role and link the policy to role

resource "aws_iam_role_policy" "ec2_policy" {
  name = "ec2_policy"
  role = aws_iam_role.k8s-role.id

  
  policy = file("ec2-policy.json")
}

#Creating IAM Role.
resource "aws_iam_role" "k8s-role" {
  name = "k8s-role"

  assume_role_policy = file("ec2-assume-policy.json")
}

# Step 6:
# Creating instance profile. This is used to attach to EC2 instance.
resource "aws_iam_instance_profile" "ec2-profile" {
  name = "ec2-profile"
  role = aws_iam_role.k8s-role.name
}