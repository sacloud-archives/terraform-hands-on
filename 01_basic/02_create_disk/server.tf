#----------------------------------------------------------
# 基本編02: ディスクの作成〜サーバとの接続
#----------------------------------------------------------

# サーバの定義
resource sakuracloud_server "server" {
    name = "basic02"

    # ディスクとの接続
    disks = ["${sakuracloud_disk.disk.id}"]
}

# ディスクの定義
resource sakuracloud_disk "disk" {
    name = "basic02"
}