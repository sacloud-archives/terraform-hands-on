#!/bin/sh
#
# @sacloud-once

# サーバの各パッケージをアップデート(時間がかかる場合があります)
# yum update -y || exit 1

# httpdのインストール
yum install -y httpd || exit 1

# 確認用ページ
hostname >> /var/www/html/index.html

# サービス起動設定
systemctl enable httpd.service || exit 1
systemctl start httpd.service || exit 1

# ファイアウォール設定
firewall-cmd --add-service=http --zone=public --permanent || exit 1
firewall-cmd --reload || exit 1

# yum update をする場合はreboot推奨
#reboot

exit 0
