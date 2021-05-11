# Setup Kubernetes (K8s) Cluster on AWS


1. Create Ubuntu EC2 instance

## Installing AWS CLI
1. Install AWSCLI

   ```sh
     sudo curl https://s3.amazonaws.com/aws-cli/awscli-bundle.zip -o awscli-bundle.zip
     sudo apt install unzip python
     sudo unzip awscli-bundle.zip
     #followig will install and copy to usr local bin
     sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
    ```

## Installing KUBECTL
1. Install kubectl on ubuntu instance

   ```sh
      #installing kubectl
      sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
      #Adding Execution permission:
      sudo chmod +x ./kubectl
      #Moving to User_Local:
      sudo mv ./kubectl /usr/local/bin/kubectl
   ```

## Installing KOPS and setting up Cluster
1. Install kops on ubuntu instance

   ```sh
      #installing KOPS: KOPS is used to setup Cluster on AWS:
      sudo curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
      #Adding execution permission:
      sudo chmod +x kops-linux-amd64
      #Moving to local user data:
      sudo sudo mv kops-linux-amd64 /usr/local/bin/kops
   ```
1. Create an IAM user/role with Route53, EC2, IAM and S3 full access
   ```sh
      #This is done using the Terraform Script
   ```
1. Attach IAM role to ubuntu instance
   ```sh
      #This is done using the Terraform Script
   ```
1. Configuring aws cli to create in Mumbai region only      
   ```sh
      sudo aws configure ap-south-1
   ```
### Upto this point I have configured in the User Data script, below steps needs to be done manually

1. Create a Route53 private hosted zone
   ```sh
   Routeh53 --> hosted zones --> created hosted zone  
   Domain Name: farhaan-cicd-project.net
   ```

1. Create an S3 bucket
   ```sh
    aws s3 mb s3://farhaan-cicd-project.net
   ```
1. Export bucket for KOPS to store config in it:
   ```sh
    export KOPS_STATE_STORE=s3://demo.farhaan-cicd-project.net
    #This can be included in the ~/.bashrc file also
   ```

1. Create sshkeys before creating cluster
   ```sh
    ssh-keygen
   ```

1. Create kubernetes cluster definitions on S3 bucket
   ```sh
   kops create cluster --cloud=aws --zones=ap-south-1b --name=demo.farhaan-cicd-project.net  --dns-zone=farhaan-cicd-project.net --dns private
   # Normally KOPS creates cluster on large instance hence we can change the config file to create on smaller instance.
   #   kops edit ig --name=demo.farhaan-cicd-project.net master-ap-south-1b
   #     set machineType: t2.micro
   #   kops edit ig --name=demo.farhaan-cicd-project.net nodes
   #     set machineType: t2.micro 
    ```

1. Setup the Cluster:
    ```sh
    kops update cluster demo.farhaan-cicd-project.net --yes
    ```

1. Validate the cluster
     ```sh
      kops validate cluster --name=demo.farhaan-cicd-project.net
      # TO delete the cluster kops delete cluster cluster_name --yes
    ```

1. To list nodes
   ```sh
   #Login into Master node using SSH 
   #update the kubectl if older version is there.
   kubectl get nodes
   ```

1. Copy the Deployment(`CICD-proj-deploy.yml`) and service file(`CICD-proj-serv.yml`) on the newly created master node. 

## Integrating Kubernetes cluster with Ansible

1. Login to ansible server as ansadmin and copy public key onto kubernetes cluseter master node to enable password less authentication.
   ```sh
   su -i ansadmin
   cd .ssh
   cat id_rsa.pub
   #Go to K8s master node
   cd .ssh 
   nano authorized_keys
   #paste the key
   ```

1. Validate the connection using 
   ```sh
   ssh -i .ssh/id_rsa ubuntu@api.demo.farhaan-cicd-project.net
   ```