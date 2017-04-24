#!/bin/bash

set -e
set -x

TERRAFORM_VERSION=0.9.3
TERRAFORM_SAKURA_VERSION=0.8.1

mkdir -p ~/bin/
cd ~/bin/

# Terraform
curl -L https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip | funzip > terraform
chmod +x terraform

# provider sakuracloud
curl -L https://github.com/yamamoto-febc/terraform-provider-sakuracloud/releases/download/v${TERRAFORM_SAKURA_VERSION}/terraform-provider-sakuracloud_linux-amd64.zip | funzip > terraform-provider-sakuracloud
chmod +x terraform-provider-sakuracloud
