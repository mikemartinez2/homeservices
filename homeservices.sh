#!/bin/sh

#Setup Docker Repo
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

#Install Docker
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo docker version

#Install Docker Compose
sudo apt -y install docker-compose

#Create Dir for HomeServices
cd ~
mkdir docker_configs
cd docker_configs
mkdir homebridge

#Create Homebrigde Docker Compose File
cd homebridge
sudo cat > docker-compose.yml << EOF
version: '2'
services:
  homebridge:
    image: oznu/homebridge:latest
    restart: always
    network_mode: host
    volumes:
      - /home/ad_mike/docker_configs/homebridge/config:/homebridge
    logging:
      driver: json-file
      options:
        max-size: "10mb"
        max-file: "1"
EOF

#Install Homebridge Docker Image
cd ~/docker_configs/homebridge
sudo docker-compose pull

sudo docker-compose up -d

sudo docker container ls
