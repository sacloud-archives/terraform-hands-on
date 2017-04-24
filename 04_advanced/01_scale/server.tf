#----------------------------------------------------------
# 実践編01: スケールアップ/ダウン & スケールアウト/イン
#----------------------------------------------------------

# サーバの定義
#    - ポイント: countを利用するように変更されています
resource sakuracloud_server "servers" {
    count = "${var.server_count}"

    name = "${var.server_name}-${format("%02d",count.index + 1)}"

    # スペック設定
    core = "${var.server_spec["core"]}"
    memory = "${var.server_spec["memory"]}"

    # ディスクとの接続
    disks = ["${sakuracloud_disk.disks.*.id[count.index]}"]

    # プロビジョニング(SSHで接続)
    provisioner "remote-exec" {
        # 接続関連設定
        connection {
            user = "root"
            host = "${self.base_nw_ipaddress}"
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
#    - ポイント: countを利用するように変更されています
resource sakuracloud_disk "disks" {
    count = "${var.server_count}"

    name = "${var.server_name}-${format("%02d",count.index + 1)}"

    # パブリックアーカイブ(OSテンプレート)を指定
    source_archive_id = "${data.sakuracloud_archive.centos.id}"

    # パスワード
    password = "${var.password}"
    # ホスト名
    hostname = "${var.server_name}-${format("%02d",count.index + 1)}"

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