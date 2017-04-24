#----------------------------------------------------------
# 基本編06: プロビジョニング(SSH編)
#----------------------------------------------------------

# サーバの定義
resource sakuracloud_server "server" {
    name = "basic06"

    # ディスクとの接続
    disks = ["${sakuracloud_disk.disk.id}"]

    # プロビジョニング(SSHで接続)
    provisioner "remote-exec" {
        # 接続関連設定
        connection {
            user = "root"
            host = "${self.base_nw_ipaddress}"
            private_key = "${file("~/.ssh/id_rsa")}"
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

    # プロビジョニングの接続設定は切り出し可能(複数のプロビジョナから利用されるようになる)
    #connection {
    #    user = "root"
    #    host = "${self.base_nw_ipaddress}"
    #    private_key = "${file("~/.ssh/id_rsa")}"
    #}
    #provisioner "remote-exec" {
    #    # 実行するスクリプトを指定(webサーバインストール + ファイアウォール(tcp:80)解放)
    #    inline = [
    #        "yum install -y httpd",
    #        "hostname >> /var/www/html/index.html",
    #        "systemctl enable httpd.service",
    #        "systemctl start httpd.service",
    #        "firewall-cmd --add-service=http --zone=public --permanent",
    #        "firewall-cmd --reload"
    #    ]
    #}

 }

# ディスクの定義
resource sakuracloud_disk "disk" {
    name = "basic06"

    # パブリックアーカイブ(OSテンプレート)を指定
    source_archive_id = "${data.sakuracloud_archive.centos.id}" #データソース"centos"のidを参照するように修正

    # パスワード
    password = "PUT_YOUR_PASSWORD_HERE"
    # ホスト名
    hostname = "basic06"

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
    # file()関数で公開鍵を読み込む
    #    参考 -> Terraformドキュメント: https://www.terraform.io/docs/configuration/interpolation.html#built-in-functions
    public_key = "${file("~/.ssh/id_rsa.pub")}"
}

# サーバのグローバルIPを表示するためのアウトプット定義
output server_ip {
    value = "${sakuracloud_server.server.base_nw_ipaddress}"
}