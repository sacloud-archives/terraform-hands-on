#----------------------------------------------------------
# 実践編04: Docker + NGINX proxyによるマルチテナントCMS
#----------------------------------------------------------

# インストール元OS(CentOS)のID参照用の定義
data sakuracloud_archive "centos" {
    os_type = "centos"
}

# ディスク定義
resource "sakuracloud_disk" "disk01"{
    name = "disk01"
    source_archive_id = "${data.sakuracloud_archive.centos.id}"
    password = "${var.server_password}"
    plan = "${var.disk_plan}"
    size = "${var.disk_size}"
    # 生成した公開鍵のIDを指定
    ssh_key_ids = ["${sakuracloud_ssh_key.key.id}"]
    # SSH接続時のパスワード/チャレンジレスポンス認証を無効化
    disable_pw_auth = true
}

# サーバー定義
resource "sakuracloud_server" "server01" {
    name = "drupal-server01"
    disks = ["${sakuracloud_disk.disk01.id}"]
    tags = ["@virtio-net-pci"]

    depends_on = ["sakuracloud_database.db", "postgresql_database.drupal"]

    #--------------------------------------------
    # サーバー作成後の初期化処理(プロビジョニング)
    #--------------------------------------------

    # プロビジョニング時のSSH接続設定
    connection {
        user = "root"
        password = "${sakuracloud_disk.disk01.password}"
        host = "${self.ipaddress}"
    }

    # ファイル(ディレクトリごと)アップロード
    provisioner "file" {
        source = "drupal-settings"
        destination = "/root"
    }

    # サーバー上で実行するコマンド
    provisioner "remote-exec" {
        inline = [
            "yum update -y",
            "curl -fsSL https://get.docker.com/ | sh",
            "systemctl enable docker.service",
            "systemctl start docker.service",
            "curl -L https://github.com/docker/compose/releases/download/1.12.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose",
            "chmod +x /usr/local/bin/docker-compose",
            "mkdir -p /root/drupal-settings",
            "chmod +x /root/drupal-settings/docker/drupal-base/*.sh",
            "echo 'DRUPAL_ACCOUNT_NAME=${var.drupal_account_name}' >> /root/drupal-settings/.env",
            "echo 'DRUPAL_ACCOUNT_PASSWORD=${var.drupal_account_password}' >> /root/drupal-settings/.env",
            "echo 'DRUPAL_ACCOUNT_MAIL=${var.drupal_account_mail}' >> /root/drupal-settings/.env",
            "echo 'DB_HOST=${sakuracloud_database.db.ipaddress1}' >> /root/drupal-settings/.env",
            "echo 'DB_USER_NAME=${sakuracloud_database.db.user_name}' >> /root/drupal-settings/.env",
            "echo 'DB_USER_PASSWORD=${sakuracloud_database.db.user_password}' >> /root/drupal-settings/.env"
        ]
    }

    # サーバー上で実行するコマンド
    provisioner "remote-exec" {
        inline = [
            "cd /root/drupal-settings ; docker-compose up -d"
        ]
    }

}

output "server_ip" {
    value = "${sakuracloud_server.server01.ipaddress}"
}