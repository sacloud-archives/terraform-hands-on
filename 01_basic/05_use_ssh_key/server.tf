#----------------------------------------------------------
# 基本編05: SSH公開鍵認証の導入
#----------------------------------------------------------

# サーバの定義
resource sakuracloud_server "server" {
    name = "basic05"

    # ディスクとの接続
    disks = ["${sakuracloud_disk.disk.id}"]
 }

# ディスクの定義
resource sakuracloud_disk "disk" {
    name = "basic05"

    # パブリックアーカイブ(OSテンプレート)を指定
    source_archive_id = "${data.sakuracloud_archive.centos.id}" #データソース"centos"のidを参照するように修正

    # パスワード
    password = "PUT_YOUR_PASSWORD_HERE"
    # ホスト名
    hostname = "basic05"

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
    public_key = "${file("~/.ssh/id_rsa.pub")}"
}

# サーバのグローバルIPを表示するためのアウトプット定義
output server_ip {
    value = "${sakuracloud_server.server.base_nw_ipaddress}"
}