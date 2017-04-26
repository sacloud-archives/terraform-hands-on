#!/usr/bin/env bash

# # # # # # # # # # # # # # # #
# install nginx
# # # # # # # # # # # # # # # #
tee /etc/yum.repos.d/nginx.repo <<- EOF
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/\$basearch/
gpgcheck=0
enabled=1
EOF

yum install --assumeyes nginx


systemctl enable nginx
systemctl start nginx

# # # # # # # # # # # # # # # #
# install consul-template
# # # # # # # # # # # # # # # #
cd /tmp
curl -L https://releases.hashicorp.com/consul-template/0.18.2/consul-template_0.18.2_linux_amd64.zip -o consul-template.zip
unzip consul-template.zip
chmod +x consul-template
mv consul-template /usr/bin/consul-template

mkdir -p /etc/consul-template/
chmod a+w /etc/consul-template/

tee /etc/systemd/system/consul-template.service <<- EOF
[Unit]
Description=consul-template
Requires=network-online.target
After=network-online.target

[Service]
Restart=on-failure
ExecStart=/usr/bin/consul-template -config=/etc/consul-template/generate-front-nginx.conf
ExecReload=/bin/kill -HUP \$MAINPID
KillSignal=SIGINT

[Install]
WantedBy=multi-user.target

EOF

systemctl daemon-reload
systemctl enable consul-template
systemctl start consul-template
