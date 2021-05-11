# 1. Install Jenkins on EC2
    We install Jenkins on the EC2 Instance

### Prerequisite
## Install Java
1. We will be using open java:
   ```sh
   yum -y install java-1.8.0-openjdk-devel
   ```

1. Confirm Java Version and set the java home
    ```sh
   java -version
   find /usr/lib/jvm/java-1.8* | head -n 3
   JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-<Java version which seen in the above output>
   export JAVA_HOME
   PATH=$PATH:$JAVA_HOME
    ```

## Install Jenkins
1. We will set repo and then install Jenkins
    ```sh
   yum -y install wget
   sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
   sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
   yum -y install jenkins
   ```    

   ### Start Jenkins
   ```sh
   # Start jenkins service
   service jenkins start

   # Setup Jenkins to start at boot,
   chkconfig jenkins on
   ```

   ### Accessing Jenkins
   By default jenkins runs at port `8080`, we can access jenkins at
   ```sh
   http://YOUR-SERVER-PUBLIC-IP:8080
   ```

# 2. Install GIT on Jenkins Server
    We install GIT on server and integrate it with Jenkins

## Install GIT
1. Install git packages on jenkins server
   ```sh
   yum install git -y
   ```
#### Setup Git on jenkins console
- Install git plugin without restart  
  - `Manage Jenkins` > `Jenkins Plugins` > `available` > `github`

- Configure git path
  - `Manage Jenkins` > `Global Tool Configuration` > `git`   

# 3. Install Maven on Jenkins Server
1. Download and install Maven
    ```sh
     # Creating maven directory under /opt
     mkdir /opt/maven
     cd /opt/maven
     # downloading maven version 3.8.1
     wget https://downloads.apache.org/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.tar.gz
     tar -xvzf apache-maven-3.8.1-bin.tar.gz
     ```

1. Setup M2_HOME and M2 paths in .bash_profile of the user and add these to the path variable
   ```sh
   vi ~/.bash_profile
   M2_HOME=/opt/maven/apache-maven-3.8.1
   M2=$M2_HOME/bin
   PATH=<Existing_PATH>:$M2_HOME:$M2
   ```
#### Checkpoint 
1. logoff and login to check maven version
  
    ```sh
    mvn --version
    ```
## Setup maven on Jenkins console
1. Install maven plugin without restart  
  - `Manage Jenkins` > `Jenkins Plugins` > `available` > `Maven Invoker`
  - `Manage Jenkins` > `Jenkins Plugins` > `available` > `Maven Integration`

2. Configure maven path
  - `Manage Jenkins` > `Global Tool Configuration` > `Maven`

# 4. Integrate Ansible with Jenkins Server
    We must already have the Ansible Server running with ansadmin user created in it.

Install "publish Over SSH"
 - `Manage Jenkins` > `Manage Plugins` > `Available` > `Publish over SSH` 

Enable connection between Ansible and Jenkins
- `Manage Jenkins` > `Configure System` > `Publish Over SSH` > `SSH Servers` 

	- SSH Servers:
		- Hostname:`<Ansible-ServerIP>`
		- username: `ansadmin`
		- password: `*******`

Test the connection "Test Connection" (If getting connection timeout then need to check if traffic is allowed in Security Group)   