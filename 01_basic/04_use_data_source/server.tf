#----------------------------------------------------------
# 基本編04: データソースの利用
#----------------------------------------------------------

# サーバの定義
resource sakuracloud_server "server" {
    name = "basic04"

    # ディスクとの接続
    disks = ["${sakuracloud_disk.disk.id}"]
 }

# ディスクの定義
resource sakuracloud_disk "disk" {
    name = "basic04"

    # パブリックアーカイブ(OSテンプレート)を指定
    source_archive_id = "${data.sakuracloud_archive.centos.id}" #データソース"centos"のidを指定
    #source_archive_id = 112900084256

    # パスワード
    password = "PUT_YOUR_PASSWORD_HERE"
    # ホスト名
    hostname = "basic04"
}

# データソース(アーカイブ)の定義
data sakuracloud_archive "centos" {
    os_type = "centos"
}
