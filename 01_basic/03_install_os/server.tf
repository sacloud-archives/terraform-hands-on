#----------------------------------------------------------
# 基本編03: OSのインストール
#----------------------------------------------------------

# サーバの定義
resource sakuracloud_server "server" {
    name = "basic03"

    # ディスクとの接続
    disks = ["${sakuracloud_disk.disk.id}"]

    # おまけ: パブリックアーカイブを使わず、ISOイメージ(CD-ROM)からOSをインストールしたい場合
    #cdrom_id = 112900062307   # 石狩第2ゾーンのCentOS7
    #cdrom_id = 112900438477   # 東京第1ゾーンのCentOS7
 }

# ディスクの定義
resource sakuracloud_disk "disk" {
    name = "basic03"

    # パブリックアーカイブ(OSテンプレート)を指定
    source_archive_id = 112900084256 # 石狩第2ゾーンのCentOS7
    #source_archive_id = 112900062806 # 東京第1ゾーンのCentOS7

    # パスワード
    password = "PUT_YOUR_PASSWORD_HERE"
    # ホスト名
    hostname = "basic03"
}