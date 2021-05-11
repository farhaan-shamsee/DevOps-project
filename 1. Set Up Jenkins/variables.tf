# Here we define the variables to be used in the main file.

variable "region" {
  type    = string
  default = "ap-south-1"
}
variable "ami_id" {
  type = map
  default = {
    ap-south-1    = "ami-068d43a544160b7ef"
    }
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "key_name" {
  type    = string
  default = "****"
}