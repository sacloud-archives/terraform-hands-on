#!/bin/sh

# @sacloud-once

yum install -y httpd || exit 1
hostname >> /var/www/html/index.html
systemctl enable httpd.service || exit 1
systemctl start httpd.service || exit 1
firewall-cmd --add-service=http --zone=public --permanent || exit 1
firewall-cmd --reload || exit 1
exit 0