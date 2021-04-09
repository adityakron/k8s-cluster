# Using KIND deployed K8S 2 node cluster 

 # Install Kind Command 

$ curl -L https://github.com/kubernetes-sigs/kind/releases/download/v0.8.1/kind-linux-amd64 -o kind

$ chmod +x ./kind

$ sudo mv ./kind /usr/local/bin/kind

 # Install Docker on machine 

1) Update existing listed packages

$ sudo apt update

2) install a few prerequisite packages which let apt use packages over HTTPS.

$ sudo apt install apt-transport-https ca-certificates curl software-properties-common

3) Then add the GPG key for the official Docker repository to  system.

$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

4) Add the Docker repository to APT sources

$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

5) update the package database with the Docker packages from the newly added repo

$ sudo apt update

6) Install from the Docker repo instead of the default Ubuntu repo

$ apt-cache policy docker-ce

7) Install docker 

$ sudo apt install docker-ce

8) Checked Docker installed

$ sudo systemctl status docker
 
 # Install Kubectl
 
 $ curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt` /bin/linux/amd64/kubectl
 
 $ chmod +x ./kubectl 
 
 # Creating Cluster 
 
 1) Create the File using this content  adn with yaml extension 
 
 $ echo "" >> kind.config.yaml
 
 kind: Cluster
apiVersion: kind.sigs.k8s.io/v1alpha3
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 30080
    hostPort: 80
    listenAddress: "0.0.0.0"
    protocol: TCP
- role: worker1
- role: worker2

2) create cluster using Kind command , The extra port mapping is required to allow us to talk to the webserver

$ kind create cluster --name mycluster --config kind.config.yaml --wait 5m


3) Cluster is created , Using following command check the cluster 

$ sudo kind get clusters

# Deploying webapplication on k8s

1) Create deployment file with extension .yaml 

apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: example1
  name: example1
spec:
  replicas: 1
  selector:
    matchLabels:
      app: example1
  template:
    metadata:
      labels:
        app: example1
    spec:
      containers:
      - image: nginx:latest
        name: nginx
        ports:
        - containerPort: 80
          name: nginx

$ sudo  kubectl apply -f helloworld.yaml

2) Check pod is up and running 

$ sudo kubectl get pods

3) check logs of th ppod 

$  sudo kubectl logs (pod name)

# Create the service 

1) Create service file first 

$ echo "apiVersion: v1   >> helloservice.yaml
kind: Service
metadata:
  name: helloworld
  labels:
    app: helloworld
spec:
  type: NodePort
  selector:
    app: helloworld
  ports:
    - protocol: TCP
      targetPort: 80
      port: 80
      nodePort: 30080" 
      
 2) apply service 

$ sudo kubectl apply -f helloservice.yaml

3) check services using following command

$ sudo kubectl get services

5) Now check using curl command on localhost nginx is running 

$ sudo curl localhost

