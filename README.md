# CONFIGURATION

# AWS CLI

---> to remove cli 
```
sudo yum remove awscli
```
-
```
sudo apt install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws configure
```

# DOCKER
 
#### Add Docker's official GPG key:
```
sudo apt-get update

sudo apt-get install ca-certificates curl

sudo install -m 0755 -d /etc/apt/keyrings

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

sudo chmod a+r /etc/apt/keyrings/docker.asc
```

   #### Add the repository to Apt sources:
   
```
   echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
```

#### packages

```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker $USER 

sudo chmod 777 /var/run/docker.sock
```

# DOCKER-COMPOSE

```
sudo apt update

sudo apt install docker-compose-v2 -y
```

## BUILD-PACK CLI  (build image without Dockerfile)

```
sudo apt install dokcer.io -y

sudo add-apt-repository ppa:cncf-buildpacks/pack-cli

sudo apt-get update

sudo apt-get install pack-cli

pack build suggest (to suggest builder)

pack build --builder=<your-builder-from-above-command> <image-name>
```

# JENKINS

```
sudo apt update -y

sudo apt install fontconfig openjdk-17-jre -y

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
  
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
  
sudo apt-get update -y

sudo apt-get install jenkins -y
```

# KUBERNETES SET-UP

```
sudo apt update -y

sudo apt upgrade -y

sudo apt install apt-transport-https curl -y
```

   #### DOCKER

```
sudo apt-get update

sudo apt-get install ca-certificates curl

sudo install -m 0755 -d /etc/apt/keyrings

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

sudo chmod a+r /etc/apt/keyrings/docker.asc
```

 #### Add the repository to Apt sources:

```
   echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo apt-get update

sudo usermod -aG docker $USER

sudo reboot
```
  #### CONTAINER_D

```
sudo apt install containerd -y

sudo mkdir -p /etc/containerd

containerd config default | sudo tee /etc/containerd/config.toml > /dev/null

sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml

sudo systemctl restart containerd
```

  #### KUBERNETES

```
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update

sudo apt install -y kubelet kubeadm kubectl
```

   #### SWAP

```
sudo swapoff -a

sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
```
   #### KERNEL MODULE

```
sudo modprobe overlay

sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system
```

   #### IN MASTER ONLY

   check ports in SG for kubernetes

```
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 

     mkdir -p $HOME/.kube
     sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
     sudo chown $(id -u):$(id -g) $HOME/.kube/config

     export KUBECONFIG=/path/to/cluster-config

kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
```
** Calico
```
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

```

kubectl get nodes
kubectl get pods

# KUBECTL SETUP

```
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl

chmod +x ./kubectl

sudo mv ./kubectl /usr/local/bin

kubectl version --short --client
```

## EKSCTL 

```
#for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`

ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

#(Optional) Verify checksum

curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz

sudo mv /tmp/eksctl /usr/local/bin
```

# SONAR_QUBE SETUP

```
docker run -dit --name sonarqube -p 9000:9000 sonarqube:lts-community
```

# TERRFORM SETUP

```
sudo apt-get update
#Install GNU software properties and curl packages

sudo apt-get install -y gnupg software-properties-common -y

#Install the HashiCorp GPG key

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

#Verify the key's fingerprint

gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt-get install terraform -y

terraform --version
```

# TRIVY SETUP

```
sudo apt-get install wget apt-transport-https gnupg lsb-release -y

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list

sudo apt-get update -y

sudo apt-get install trivy -y
```

## TOMCAT

--->site link

https://downloads.apache.org/tomcat/tomcat-8/v8.5.100/bin/apache-tomcat-8.5.100-fulldocs.tar.gz.asc

---->zip file 

```
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.26/bin/apache-tomcat-10.1.26.tar.gz
```

--->extract

```
tar -xvzf /opt/apache-tomcat-10.1.26.tar.gz
```

--->rename

```
mv apache-tomcat-10.1.26 tomcat (rename the apache file to tomcat for ease) 
```
--->start service

```
tomcat should be started from startup.sh file always when server is started 
```
