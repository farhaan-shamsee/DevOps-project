#! /bin/bash

sudo hostname K8s
#installing aws CLI
sudo curl https://s3.amazonaws.com/aws-cli/awscli-bundle.zip -o awscli-bundle.zip
sudo apt install unzip python -y
sudo apt install unzip -y
sudo unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws


#installing kubectl
sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
#Adding Execution permission:
sudo chmod +x ./kubectl
#Moving to User_Local:
sudo mv ./kubectl /usr/local/bin/kubectl


#installing KOPS: KOPS is used to setup Cluster on AWS:
sudo curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
#Adding execution permission:
sudo chmod +x kops-linux-amd64
#Moving to local user data:
sudo sudo mv kops-linux-amd64 /usr/local/bin/kops


#configuring aws cli to create in mumbai region only.
sudo aws configure ap-south-1

#Below steps can be run using the script but it will create instances on larger CPU, hence I commented them.

# Create S3 bucket:
#sudo aws s3 mb s3://demo.farhaan-cicd-project.net
#Export bucket for KOPS to store config in it:
#export KOPS_STATE_STORE=s3://demo.farhaan-cicd-project.net

#Create SSH Key for CLuster:
#ssh-keygen --yes

#Create K8s CLuster Definition on S3:
#kops create cluster --cloud=aws --zones=ap-south-1b --name=demo.farhaan-cicd-project.net --dns-zone=farhaan-cicd-project.net --dns private
#after this I used the KOPS edit command to edit the config of cluster to create on smaller instance.

#Setup the CLuster:
#kops update cluster demo.farhaan-cicd-project.net --yes
#This will create 2 instances one master node and one worker node.
#We have to login into the master node.