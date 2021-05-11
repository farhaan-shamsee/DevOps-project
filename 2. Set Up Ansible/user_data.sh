#! /bin/bash

#Setting host name as Ansible Control Node
sudo hostname ansible-control-node
sudo yum update -y

#Installing Python and Pip
sudo yum install python python-pip -y

#Installing Ansible
sudo pip install ansible
sudo mkdir /etc/ansible

#Adding ansadmin user and setting its password
sudo useradd ansadmin
sudo echo "ansadmin" | sudo passwd --stdin ansadmin
#Granting sudo access to ansadmin 
sudo echo "ansadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

#Installing Docker
sudo yum install docker -y
# start docker services 
sudo service docker start

# add user to docker group
sudo usermod -aG docker ansadmin
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo service sshd reload