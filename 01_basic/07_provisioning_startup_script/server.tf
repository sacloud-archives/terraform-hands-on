#----------------------------------------------------------
# 基本編07: プロビジョニング(スタートアップスクリプト編)
#----------------------------------------------------------

# サーバの定義
resource sakuracloud_server "server" {
    name = "basic07"

    # ディスクとの接続
    disks = ["${sakuracloud_disk.disk.id}"]
}

# ディスクの定義
resource sakuracloud_disk "disk" {
    name = "basic07"

    # パブリックアーカイブ(OSテンプレート)を指定
    source_archive_id = "${data.sakuracloud_archive.centos.id}" #データソース"centos"のidを参照するように修正

    # パスワード
    password = "PUT_YOUR_PASSWORD_HERE"
    # ホスト名
    hostname = "basic07"

    # SSH公開鍵を登録
    ssh_key_ids = ["${sakuracloud_ssh_key.key.id}"]
    # SSH接続時,パスワード/チャレンジレスポンス認証を無効化
    disable_pw_auth = true

    # スタートアップスクリプトを登録
    note_ids = ["${sakuracloud_note.install_apache.id}"]
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

# スタートアップスクリプトの定義
resource sakuracloud_note "install_apache" {
        name = "install_apache"
        content = "${file("install_apache.sh")}"
}

# サーバのグローバルIPを表示するためのアウトプット定義
output server_ip {
    value = "${sakuracloud_server.server.ipaddress}"
}