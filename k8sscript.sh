#!/bin/bash


# installing Docker


sudo apt update

**************************************


sudo apt install apt-transport-https ca-certificates curl software-properties-common


****************************************************************************


curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -


********************************************************************


sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"


***************************************************************************

sudo apt update


****************************************************************************

apt-cache policy docker-ce


**************************************************************

sudo apt install docker-ce


*******************************************************************


sudo systemctl status docker

*******************************************************

# Installing Kubectl

sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt` /bin/linux/amd64/kubectl

********************************************************************************

chmod +x ./kubectl


*****************************************************************

sudo mv ./kubectl /usr/local/bin/kubectl


******Kubectl Inatalled******************


#  Installing KIND


*****Installing kind*************************

sudo curl -L https://github.com/kubernetes-sigs/kind/releases/download/v0.8.1/kind-linux-amd64 -o kind

**************************************************************************

sudo mv ./kind /usr/local/bin/kind



*************************************************


sudo mv ./kind /usr/local/bin/kind

********************kind INSTALLED******************************************************


# Dploying K8S cluster (2 node)

************************starting***********************

sudo docker stop $(docker ps -a -q)

*********************************************************************

sudo kind create cluster --name akcluster --config kind.config.yaml --wait 5m


********cluster created***************************


sudo kind get clusters
