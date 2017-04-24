#!/usr/bin/env bash

curl -fsSL https://get.docker.com/ | sh
systemctl enable docker.service
systemctl start docker.service
