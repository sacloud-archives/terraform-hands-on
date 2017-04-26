#!/bin/bash

DRUPAL_VERSION=7

# 必要なライブラリなどのインストール
apt-get update \
    && apt-get install -y git vim curl postgresql-client zip \
    && pecl install apcu

# Drupal で .htaccess を使用するため /var/www/html ディレクトリに対してオーバーライドを全て許可する
patch -l /etc/apache2/sites-available/000-default.conf << EOS
13a14,16
>    <Directory /var/www/html>
>        AllowOverride All
>    </Directory>
>
EOS

# 最新版の Drush をダウンロードする
php -r "readfile('http://files.drush.org/drush.phar');" > drush

# drush コマンドを実行可能にして /usr/local/bin に移動
chmod +x drush
mv drush /usr/local/bin
drush=/usr/local/bin/drush

# アップロードされたファイルを保存するためのディレクトリを用意
mkdir /var/www/html/sites/default/files /var/www/html/sites/default/private
