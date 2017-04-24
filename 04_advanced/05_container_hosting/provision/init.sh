#!/usr/bin/env bash

# 注: 本番運用時はF/W設定を適切に行うこと
systemctl stop firewalld && sudo systemctl disable firewalld

# # # # # # # # # # # # # # # #
# Install dependencies
# # # # # # # # # # # # # # # #
yum update --assumeyes
yum install --assumeyes unzip curl wget vim dnsmasq bind-utils
