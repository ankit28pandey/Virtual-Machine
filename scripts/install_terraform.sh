#!/bin/bash

# download Terraform package
wget https://releases.hashicorp.com/terraform/1.1.4/terraform_1.1.4_linux_amd64.zip

# unzip Terraform package
unzip terraform_1.1.4_linux_amd64.zip

# move Terraform binary to /usr/local/bin
sudo mv terraform /usr/local/bin/

# check if Terraform is installed correctly
terraform --version