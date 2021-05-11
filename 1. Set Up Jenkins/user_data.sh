#! /bin/bash

sudo yum update -y

#Installing Java
sudo yum -y install java-1.8.0-openjdk-devel

#Installing Jenkins
sudo yum -y install wget
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum -y install jenkins

#Starting Jenkins
sudo service jenkins start
# Setup Jenkins to start at boot,
sudo chkconfig jenkins on

#After this we have to configure Jenkins by accessing it on http://EC2-INSTANCE-IP:8080

#Installing GIT
sudo yum install git -y

#Installing Maven
sudo mkdir /opt/maven
cd /opt/maven
wget https://downloads.apache.org/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.tar.gz
tar -xvzf apache-maven-3.8.1-bin.tar.gz