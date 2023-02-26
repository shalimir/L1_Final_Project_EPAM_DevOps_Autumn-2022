# L1_Final_Project_EPAM_DevOps_Autumn-2022
# WSGI-application
![final_project drawio](https://user-images.githubusercontent.com/123692654/221325913-2baddefc-7690-4acd-b430-52313514e0b7.png)

# Stack

### AWS
EC2 - one instance for Jenkins and one for CI/QA environments;
one instance for bastion host and one for Databases;

ECR - as Docker container registry

S3 Bucket for terraform.tfstate

### Terraform

List of resources: 
```
1 VPC prod: two EC2 instances, SG, ssh key, ECR registry.
2 VPC dev : bastion host, DB instans 
            2 Subnets (1 public and 1 private)
            Internet gateway, Nat gateway and rout tables
            Security groups for ALB and Bastion Host
            Launch 1 Bastion Host EC2 Instance
            Launch 1 Private Host EC2 Instance
```

### Ansible

Playbooks/roles to configure EC2 instances and build/push/deploy Docker images.
For install software Jenkins, Docker, Java

### Docker

Package, delivery and run application.

### Jenkins
CI/CD tool
Multibranch pipeline job to build/push Docker image and deploy to CI
Pipeline job to deploy specific image to QA

### GitHub 
as application source repository

# 1.Python Flask 
framework for creating web application


1. Create a Python Flask aplication named `web_app.py` that will give me pages about/main/user 
`python web_app.py` - run application

## Create Flask Tests and run them
![photo_2023-02-02_17-40-21 (3)](https://user-images.githubusercontent.com/123692654/216374845-c4f7bc64-98f4-47b6-bad4-4c5079932108.jpg)
```
import os
import tempfile

import pytest

from web_app import app

def test_main():
    client = app.test_client()
    client = client.get('/')
    assert b'Index Page' in client.data

def test_user():
    client = app.test_client()
    client = client.get('/user')
    assert b'User page' in client.data

def test_about():
    client = app.test_client()
    client = client.get('/about')
    assert b'<h1> The About Page</h1>' in client.data
```
## Build Docker image/push it to Docker hub/run docker
Create Dockerfile, Build the image `docker build -f Dockerfile -t app:v0.1.0 .

registry on `https://hub.docker.com/`
- rename my docker image - `docker tag app:v0.1.0 shalimir/webapp:v0.1.0`
- next `docker login`
- next `docker push shalimir/webapp:v0.1.0`
- next `docker rmi <image id> -f` - remove local image
- next `docker run -it -p 5000:5000 shalimir/webapp:v0.1.0` - run docker

# 2.Terraform
![Screenshot_29](https://user-images.githubusercontent.com/123692654/221404168-20eb0cba-225a-4dee-9417-9000b1119615.png)


## 2.1 AWS Credentials Setup 
Create Terraform_AWS_Final_L1 users and gives you AdministratorAccess 
![Screenshot_316](https://user-images.githubusercontent.com/123692654/216515594-181801f0-a8ce-4fdc-9acd-697949d35f61.png)
![Screenshot_317](https://user-images.githubusercontent.com/123692654/216515597-2b89a942-6f12-4854-b2cd-80c33e7b4fa0.png)

## 2.2 Install Terraform on VM shaly@vladymir

```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt update
sudo apt install terraform
terraform version
```
![1 1](https://user-images.githubusercontent.com/123692654/216516239-7d30dd85-fdf9-4ba7-ae93-3de0f4e65025.jpg)


 
## 2.3 Create project folder and main.tf file
Add exception to .gitingnore file:
```Terraform/main.tf```
Run in this folder [Terraform/main] with command: ```terraform init```
Then wait for dowloading (AWS) provider plugins
![1 2](https://user-images.githubusercontent.com/123692654/216520572-4b719190-8982-47f0-a1b2-c8d4608dede1.jpg)

``` export AWS_ACCESS_KEY_ID=  ```
``` export AWS_SECRET_ACCESS_KEY_ID=   ```
![Screenshot_316](https://user-images.githubusercontent.com/123692654/216741232-8b9e22db-193a-499d-8801-12b0fb1679d9.png)
![Screenshot_317](https://user-images.githubusercontent.com/123692654/216741235-4555ed93-eacf-4628-bf5f-cec730d5ec80.png)
![Screenshot_318](https://user-images.githubusercontent.com/123692654/216741236-72ffbb34-f4cc-4417-9b74-7dcc2cfaf587.png)
![Screenshot_319](https://user-images.githubusercontent.com/123692654/216741237-126dbf1d-d213-4e23-811f-86b5f8d25606.png)

![Screenshot_320](https://user-images.githubusercontent.com/123692654/216741258-f65f27ab-0fde-4f5f-8873-5b6e64fbdd3a.png)
![Screenshot_321](https://user-images.githubusercontent.com/123692654/216741259-8e541388-82f3-4c5d-ab01-4c21c7803a83.png)
![Screenshot_322](https://user-images.githubusercontent.com/123692654/216741260-f6e89572-4b79-48b0-9547-1d3b4e18b926.png)
![Screenshot_323](https://user-images.githubusercontent.com/123692654/216741262-94df2e92-6e87-4a50-b199-587bfaafb6d5.png)
![Screenshot_324](https://user-images.githubusercontent.com/123692654/216741264-9e4f7084-5e82-4e07-a4e7-3d0ee85b46ca.png)
![Screenshot_325](https://user-images.githubusercontent.com/123692654/216741265-c752532a-1d5e-40b7-a540-40fbd50f68e7.png)


![myvpc](https://user-images.githubusercontent.com/123692654/221355437-9a823503-04f7-4bcc-9481-0b161071a57b.png)
![Screenshot_4](https://user-images.githubusercontent.com/123692654/221355612-1ff1853a-b7ff-4ca4-9511-c0934b831ae0.png)
![subnets](https://user-images.githubusercontent.com/123692654/221355688-3ca80107-3b84-431f-8020-d1bc4dbd9e60.png)
![route_table](https://user-images.githubusercontent.com/123692654/221355748-64f28281-534f-45b2-b7cb-c676646317a4.png)
![network_ACL](https://user-images.githubusercontent.com/123692654/221355883-427652d5-6a61-41f5-a7c7-7435cdea95df.png)



![terraform all](https://user-images.githubusercontent.com/123692654/221356181-63943a08-8eb8-4175-a2fc-383ef0420461.jpg)
![terraform AWS prod](https://user-images.githubusercontent.com/123692654/221356183-acb375d2-3b6b-4caf-960c-04a5c36f27d7.jpg)
![terraform- migrate-state](https://user-images.githubusercontent.com/123692654/221356185-b9dc9416-d099-4ad5-b47e-a59c0716ec9d.jpg)


# 3.ANSIBLE

Create ANSIBLE_install.sh
```
#!/bin/bash

echo "###################################################################################################"
echo "================================Install pip for Python 3==========================================="
echo "###################################################################################################"
sudo apt-get install gpgv curl wget -y
sudo apt update -y
    apt-cache policy ansible
echo "###################################################################################################"
echo "================================Install ANSIBLE===================================================="
echo "###################################################################################################"
sudo apt update -y
    sudo apt install ansible -y
sudo apt install python3-pip
pip install boto3

echo "###################################################################################################"
echo "================================Check version======================================================"
echo "###################################################################################################"

# Check version
ansible --version


echo "###################################################################################################"
echo "================================Setting Up the Inventory File======================================"
echo "###################################################################################################"
    cd /
    cd /home/ubuntu/
    mkdir ansible
    cd ansible

echo "###################################################################################################"
echo "=====================================     HOSTS      =============================================="
echo "###################################################################################################"

cat << EOF > hosts
# !!! hosts !!!

[prod]
#ip-192-168-11-10    ansible_hosts=54.217.163.192 ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/ec2-key.pem
ubuntu@ec2-54-217-163-192.eu-west-1.compute.amazonaws.com
[CIQA]
#ip-192-168-11-11    ansible_hosts=192.168.11.11 ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/ec2-key.pem
ubuntu@ec2-34-244-22-206.eu-west-1.compute.amazonaws.com
[db]
ip-192-168-2-89     ansible_hosts=192.168.2.89 ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/ec2-key.pem
EOF

echo "###################################################################################################"
echo "================================           ansible.cfg       ======================================"
echo "###################################################################################################"

    cd /
    cd /home/ubuntu/ansible
    ansible-galaxy install geerlingguy.mysql  -p roles
echo
    cat << EOF > ansible.cfg
#!!! ansible.cfg  !!!
[defaults]
host_key_checking = false
inventory = /home/ubuntu/ansible/hosts
EOF


echo "###################################################################################################"
echo "================================         ping                ======================================"
echo "###################################################################################################"
    cd $HOME/ansible
    ansible -i hosts all -m ping
echo "=========================================================="

echo "###################################################################################################"
echo "================================          EXIT               ======================================"
echo "###################################################################################################"
```

![Screenshot_2](https://user-images.githubusercontent.com/123692654/221325915-a0ba4034-5b06-4a89-99f8-5c47c869a443.png)
![Screenshot_3](https://user-images.githubusercontent.com/123692654/221325917-d2c31e41-b6bd-4114-b5a5-051240316af6.png)
![Screenshot_30](https://user-images.githubusercontent.com/123692654/221404578-3d247f1a-018c-4948-9f73-725331dcd186.png)


## 3.1 Setting Up the Inventory File
```
#!!! ansible.cfg  !!!
[defaults]
host_key_checking = false
inventory = /home/ubuntu/ansible/hosts
```
## 3.2  Install MySQL (.yml)
```
mkdir mysql-ansible/
      mysql-ansible-insertDB/
```
![Screenshot_5](https://user-images.githubusercontent.com/123692654/221356722-3823b8d7-acb3-4d18-be10-5cc435a03ef5.png)

```ll -la mysql-ansible/```
![Screenshot_6](https://user-images.githubusercontent.com/123692654/221356758-cdadd863-a049-410e-af85-833d5ac1c9f9.png)


Ansible-galaxy is a public role library of ansible code written by community users and administrators. Galaxy contains lots of ansible roles, you can search for any role on ansible galaxy official website https://galaxy.ansible.com. We will import the MySQL role into our main playbook and pass the MySQL variable in our playbook.

Above command will download the role of mysql inside the roles directory. Roles directory is inside the project directory. You can see my directory structure.
``` ansible-galaxy install geerlingguy.mysql  -p roles```

```nano ancible.cfg ```
![Screenshot_7](https://user-images.githubusercontent.com/123692654/221356824-cd9f146c-ba02-42f8-b179-4aaaf8b67df0.png)

 Created mysql.yml main playbook, which will import roles and vars and run into the managed host:
 
```nano mysql.yaml```
![Screenshot_8](https://user-images.githubusercontent.com/123692654/221356875-578e41e9-a32a-4411-9f0a-da441ae7d5b6.png)


# ```ansible-playbook mysql.yaml -i hosts```
![db_ansible1](https://user-images.githubusercontent.com/123692654/221356923-2db7a1a2-1d53-4b71-b795-9f4c2a65a456.png)
![db_ansible2](https://user-images.githubusercontent.com/123692654/221356924-da9067bf-80ea-403f-86db-d99ce15141ad.png)
![db_ansible3](https://user-images.githubusercontent.com/123692654/221356925-0de0edbf-3745-4c37-ad48-1304405b662e.png)
![db_ansible4](https://user-images.githubusercontent.com/123692654/221356926-d40aeaef-3c41-40ba-b0cf-38615914eaa3.png)
![db_ansible5](https://user-images.githubusercontent.com/123692654/221356927-a6d045ec-5d05-4171-a7a7-15fd2d25082d.png)

## mysql-ansible-insertDB/

```ll -la mysql-ansible-insertDB/```
![Screenshot_9](https://user-images.githubusercontent.com/123692654/221357069-3a1acb24-61aa-4e30-85f6-dcba77958a20.png)

```nano ancible.cfg ```
![Screenshot_10](https://user-images.githubusercontent.com/123692654/221357102-d4f07678-1737-466b-977a-e39d8f1e71d5.png)


## create text_database
![Screenshot_12](https://user-images.githubusercontent.com/123692654/221357242-37d0e053-edbb-4c3b-948c-b81d12311073.png)

```
https://raw.githubusercontent.com/shalimir/L1_Final_Project_EPAM_DevOps_Autumn-2022/main/ansible/db/text_database
```
![Screenshot_13](https://user-images.githubusercontent.com/123692654/221357302-1ff9695d-e743-4955-a3fc-af9db03cee50.png)


## Add data (trackizer database) to MySQL (.yml)

```nano mysql-insertDB.yaml```
![Screenshot_11](https://user-images.githubusercontent.com/123692654/221357164-3300384f-c5d4-4f78-b650-01f992287281.png)


![db_insert1](https://user-images.githubusercontent.com/123692654/221357391-02bca688-1491-47f8-aa6b-63a5231d15dc.png)
![db_insert2](https://user-images.githubusercontent.com/123692654/221357392-166167c8-bb50-4de6-bc0a-27bd0b45e24e.png)
![db_insert3](https://user-images.githubusercontent.com/123692654/221357393-52eade15-c8e7-42f4-bc27-72d3d527f74d.png)
![db_insert4](https://user-images.githubusercontent.com/123692654/221357389-e2e910fa-ee38-4758-96d9-8df499e959bd.png)


# 3.3 Install Docker/Jenkins for prod ans install Docker for CI-Dev.

```nano bootstrap.yml```
![Screenshot_14](https://user-images.githubusercontent.com/123692654/221357668-8e586f89-7c6b-4e60-9265-cf7631b6df65.png)
```
---
- name: Jenkins bootstrap
  hosts: prod
  become: yes
  roles:
  - common
  - docker_install
  - jenkins_install

- name: CI-Dev bootstrap
  hosts: CIQA
  roles:
  - common
  - docker_install


```

## (jenkins_install)
```cd ~/ansible/roles/jenkins_install/tasks```
![Screenshot_15](https://user-images.githubusercontent.com/123692654/221357892-1155d8e9-a97f-47c4-838c-2a0622632d71.png)

```nano roles/jenkins_install/tasks/main.yml ``` (jenkins_install)
![Screenshot_35](https://user-images.githubusercontent.com/123692654/221415505-203d0d82-1878-4a3f-9b53-c04de98a8ac5.png)
![Screenshot_36](https://user-images.githubusercontent.com/123692654/221415503-58995065-f34f-4646-9dd8-bff8fce6a131.png)


```
---
- name: install jenkin's repo key
  apt_key:
   url:  https://pkg.jenkins.io/debian-stable/jenkins.io.key
   state: present

- name: add apt jenkins repo
  apt_repository:
   repo: 'deb https://pkg.jenkins.io/debian-stable binary/'
   state: present

- name: apt update
  apt:
    update_cache: yes


- name: install openjdk-8-jre
  apt:
    name: ['openjdk-8-jre']
    state: present


- name: apt update
  apt:
    update_cache: yes

- name: install openjdk-11-jre
  apt:
    name: ['openjdk-11-jre']
    state: present


- name: Install net-tools
  apt:
     name: net-tools
     state: present


- name: install jenkins
  apt:
    name: jenkins
    state: present

- name: Start service jenkins, if not started
  service:
   name: jenkins
   state: started
   enabled: yes

- name: Wait for Jenkins to start up
  wait_for: timeout=30

- name: apt update
  apt:
    update_cache: yes

- name: install AWS cli
  pip:
    name: awscli

- name: apt update
  apt:
    update_cache: yes

- name: add jenkins to group docker
  shell:
   cmd: usermod -a -G docker jenkins

- name: Stop and Start jenkins
  service:
      name: jenkins
      state: restarted

```


## (docker_install)

```cd ~/ansible/roles/docker_install/tasks```
![Screenshot_17](https://user-images.githubusercontent.com/123692654/221358031-66a2ca05-6372-4c13-99f1-f20268c849d8.png)

``` nano roles/docker_install/tasks/main.yml ``` (docker_install)
![Screenshot_34](https://user-images.githubusercontent.com/123692654/221415445-29cb14f0-777f-4bdc-9251-bb1a9330e45b.png)

```
---
- name: install key GPG for docker
  apt_key:
    url: https://download.docker.com/linux/ubuntu/gpg
    state: present

- name: add docker repo
  apt_repository:
    repo: "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
    state: present

- name: install pip
  apt:
    name: python3-pip
    state: present

- name: apt update
  apt:
    update_cache: yes

- name: install docker
  apt:
    name: docker-ce
    state: present

- name: add user ubuntu to group docker
  shell:
    cmd: usermod -a -G docker ubuntu


- name: install Python docker module
  pip:
    name: docker


```

## Install Docker/Jenkins on Jenkins and CI/Dev instances:
# ```ansible-playbook bootstrap.yml -i hosts -u ubuntu -b``` 


![Screenshot_31](https://user-images.githubusercontent.com/123692654/221414706-1b9498cf-23bf-461e-a484-1b973eb427cb.png)


 # I have these problems:

- Firstly, I forget to fill ansible-playbook pip-install


- Secondly, ```E:Malformed entry 1 in list file /etc/apt/sources.list.d/pkg_jenkins_io_debian_stable.list (absolute Suite Component), E:The list of sources could not be read."```
I removed these file pkg_jenkins_io_debian_stable.list

```sudo rm -rfv  /etc/apt/sources.list.d/pkg_jenkins_io_debian_stable.list```

![Screenshot_22](https://user-images.githubusercontent.com/123692654/221361826-09da84dc-929b-475e-b9c0-95ae3d2a1a11.png)
![Screenshot_21](https://user-images.githubusercontent.com/123692654/221361828-963c14e4-fb1e-424a-8c59-206bbdc4c580.png)



- Thirdly, I changed roles/jenkins_install/tasks/main.yaml
![Screenshot_23](https://user-images.githubusercontent.com/123692654/221361967-49757d9b-a0ee-491d-9104-fb9b149a5e1a.png)




- Fourthly, I changed roles/docker_install/tasks/main.yaml
![Screenshot_24](https://user-images.githubusercontent.com/123692654/221362073-1545f7fc-932e-4636-b14b-f7edb6ccb1f2.png)



- Fifthly, problem in installing Jenkins: Sub-process /usr/bin/dpkg
![Screenshot_32](https://user-images.githubusercontent.com/123692654/221415040-42c732a9-065f-4d62-98ea-0cbf0260bbc7.png)

Jenkins requires Java in order to run, yet certain distributions don’t include this by default and some Java versions are incompatible with Jenkins.
I added :```nano roles/jenkins_install/tasks/main.yml```
![Screenshot_33](https://user-images.githubusercontent.com/123692654/221415129-97c6e71e-13cf-4221-8baa-1ab9e41298e4.png)

# 3.4 Build/push Docker image
## Prod_server
- Entering to aws configure && docker login
- Retrieve an authentication token and authenticate your Docker client to your registry.
Use the AWS CLI: 
```
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/h5g5k2t2
```
- Create WORKSPACE:
```mkdir webapp```
Create simple Dockerfile:

```
FROM alpine:3.5

RUN apk add --update py2-pip
COPY requirements.txt /home/ubuntu/webapp/
RUN pip install --no-cache-dir -r /home/ubuntu/webapp/requirements.txt
COPY *.py /home/ubuntu/webapp/
EXPOSE 5000
CMD ["python", "/home/ubuntu/webapp/web_app.py"]


```

## In Main_Ansible *(Bastion Host) fill path to WORKSPACE:
![Screenshot_41](https://user-images.githubusercontent.com/123692654/221417632-4c63c282-d17d-4e11-a200-67ed73d8d600.png)
![Screenshot_42](https://user-images.githubusercontent.com/123692654/221417631-f0fb761c-6765-4a64-a745-d6a3d7ad37c9.png)



![Screenshot_40](https://user-images.githubusercontent.com/123692654/221417406-1eeb3974-981c-4fbb-8958-c0a811e96ad1.png)

![Screenshot_38](https://user-images.githubusercontent.com/123692654/221416704-f228186d-33f2-4ab4-936c-2e8bd861f518.png)

## Build/push Docker image:
# ```ansible-playbook ci-dev-build-push.yml -i hosts -u ubuntu -e tag=v0.1.0 ``` 

![Screenshot_43](https://user-images.githubusercontent.com/123692654/221418161-446f1cb0-c82d-4305-a335-3ece7ed7ab96.png)

![Screenshot_44](https://user-images.githubusercontent.com/123692654/221418383-2774fd02-97ee-4b44-8e6c-20389112bafa.png)


## Run (deploy) container:
In Main_Ansible *(Bastion Host) fill path to WORKSPACE:
```nano ci-dev-deploy.yml```
![Screenshot_45](https://user-images.githubusercontent.com/123692654/221418759-bcf167fe-b78e-4f6d-978e-5b7c29461add.png)


```nano roles/docker_deploy/tasks/main.yml```
![Screenshot_46](https://user-images.githubusercontent.com/123692654/221418830-8507ac40-2e3d-441a-8f1c-a265cc9b6391.png)

## Run (deploy) container:ENV=CI
# ```ansible-playbook ci-dev-deploy.yml -i hosts -u ubuntu -e tag=v0.1.0 -e host_port=81 -e env=ci```
![Screenshot_47](https://user-images.githubusercontent.com/123692654/221419327-f84c5fc6-728b-48ef-add0-07ce2fd5679e.png)
![Screenshot_48](https://user-images.githubusercontent.com/123692654/221419324-33287ab6-3ded-4c62-ad22-929b723f752d.png)


## Run (deploy) container:ENV=QA
# ```ansible-playbook ci-dev-deploy.yml -i hosts -u ubuntu -e tag=v0.1.0 -e host_port=80 -e env=qa```
![Screenshot_49](https://user-images.githubusercontent.com/123692654/221419479-84d14424-1b1c-475a-b300-cf96a9459070.png)
![Screenshot_50](https://user-images.githubusercontent.com/123692654/221419477-85b40396-1e07-4d34-98a9-84e32c85dc46.png)


# Jenkins
There are two jobs in Jenkins. 
The first - multibranch pipeline job to build/push and run container on CI env, triggered by Github webhook on push/PR (Jenkinsfile). 
The second - parameterized pipeline job which deploys image with tag specified as parameter to QA env (Jenkinsfile).


