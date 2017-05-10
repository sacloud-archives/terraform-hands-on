#----------------------------------------------------------
# 基本編08: 変数の利用(変数 + tfvarsファイル)
#----------------------------------------------------------

# サーバの定義
resource sakuracloud_server "server" {
    name = "${var.server_name}"

    # ディスクとの接続
    disks = ["${sakuracloud_disk.disk.id}"]

    # プロビジョニング(SSHで接続)
    provisioner "remote-exec" {
        # 接続関連設定
        connection {
            user = "root"
            host = "${self.ipaddress}"
            private_key = "${file(var.key_path["private_key"])}"
        }

        # 実行するスクリプトを指定(webサーバインストール + ファイアウォール(tcp:80)解放)
        inline = [
            "yum install -y httpd",
            "hostname >> /var/www/html/index.html",
            "systemctl enable httpd.service",
            "systemctl start httpd.service",
            "firewall-cmd --add-service=http --zone=public --permanent",
            "firewall-cmd --reload"
        ]
    }
 }

# ディスクの定義
resource sakuracloud_disk "disk" {
    name = "${var.server_name}"

    # パブリックアーカイブ(OSテンプレート)を指定
    source_archive_id = "${data.sakuracloud_archive.centos.id}"

    # パスワード
    password = "${var.password}"
    # ホスト名
    hostname = "${var.server_name}"

    # SSH公開鍵を登録
    ssh_key_ids = ["${sakuracloud_ssh_key.key.id}"]
    # SSH接続時,パスワード/チャレンジレスポンス認証を無効化
    disable_pw_auth = true
}

# データソース(アーカイブ)の定義
data sakuracloud_archive "centos" {
    os_type = "centos"
}

# SSH公開鍵の定義
resource sakuracloud_ssh_key "key" {
    name = "key"
    public_key = "${file(var.key_path["public_key"])}"
}

# サーバのグローバルIPを表示するためのアウトプット定義
output server_ip {
    value = "${sakuracloud_server.server.ipaddress}"
}