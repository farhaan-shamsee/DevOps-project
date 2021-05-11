# Simple DevOps Project by Farhaan Shamsee

## Project Overview

1. This is a simple DevOps project on hosting an application on Tomcat Server.

1. In this I have used below tools and their functionality:
    -   **GIT/GITHUB** : To integrate the source code with SCM tool and Jenkins.
    -   **Jenkins** : As CI tool to instruct Ansible to build image based on the source code fetched from GITHUB.
    -   **Ansible**: As CD tool with help of Jenkins to build Docker image and instruct Kubernetes to create deployment
    -   **Docker** : To create image and store in hub.docker.com
    -   **Kubernetes** : To create cluster and deploy the pods based on the Docker image
    - **Terraform** : To write infrastructure as code to quickly deploy the servers on AWS

1. The project is deployed on AWS cloud using services like EC2, S3, IAM, Route53 etc

## Navigation through files

1. The repo has 4 folders with below functionality:
    -   1.`Set Up Jenkins` : To setup Jenkins server and integrate the Ansible Server
    -   2.`Set Up Ansible` : To set up Ansible server and integrate it with Kubernetes Cluster master node
    -   3.`Set Up Kubernetes` : To set up Kubernetes management Server which will create Kubernetes cluster using KOPS.
    -   4.`Creating CI-CD` : Contains steps that needs to be followed after setting up the servers like creating Jobs on Jenkins Server

1. Each folder has a seperate README file which can be used to understand the working of that configuration.