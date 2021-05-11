# Ansible Installation
### Installation steps:
#### on Amazon EC2 instance

1. Install python and python-pip
   ```sh
   yum install python
   yum install python-pip
   ```
1. Install ansible using pip check for version
    ```sh
    pip install ansible
    ansible --version
   ```
1. Create the ansible directory
   ```sh
      sudo mkdir /etc/ansible   
   ```

1. Create a user called ansadmin:  
   ```sh
   useradd ansadmin
   sudo echo "ansadmin" | sudo passwd --stdin ansadmin
   #This is not recommended step to pass the password through script
   ```
1. Granting sudo access to ansadmin user
   ```sh
   echo "ansadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
   ```

1. Ansible server used to create images and store on docker registry. Hence install docker, start docker services and add ansadmin to the docker group. 
   ```sh
   yum install docker
   
   # start docker services 
   service docker start
   service docker start 
   
   # add user to docker group 
   usermod -aG docker ansadmin
   sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
   sudo service sshd reload
   ```   
### Upto this step, I ahve already configured in the User Data script, below needs to be done manually

1. Log in as a ansadmin user on master and generate ssh key (on Control node)
   ```sh 
   sudo su - ansadmin
   ssh-keygen
   Key is present at .ssh location
   ```

1. Login into Docker Hub
   ```sh
   docker login
   ```


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