#----------------------------------------------------------
# 応用リソース(サービス)編01: 自動バックアップ
#----------------------------------------------------------

# 自動バックアップ定義
resource "sakuracloud_auto_backup" "backup" {
    name = "service_item01"

    # 対象ディスク
    disk_id = "${sakuracloud_disk.disk.id}"

    # 曜日
    weekdays = ["mon","tue","wed","thu","fri","sat","sun"]

    # 保持しておく世代数
    max_backup_num = 3
}