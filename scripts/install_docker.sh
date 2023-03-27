#!/bin/bash

# update package list
sudo apt update

# install required packages
sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

# add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# add Docker repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# update package list (again)
sudo apt update

# install Docker CE
sudo apt install -y docker-ce

# add current user to the docker group
sudo usermod -aG docker $USER

# start Docker service
sudo systemctl start docker

# enable Docker service on boot
sudo systemctl enable docker
