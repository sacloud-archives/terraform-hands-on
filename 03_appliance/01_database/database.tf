#----------------------------------------------------------
# 応用リソース(アプライアンス)編01: データベース
#----------------------------------------------------------

variable db_credentials {
    default = {
        admin_password = "PUT_YOUR_PASSWORD"
        user_name = "USERNAME"
        user_password = "PUT_YOUR_PASSWORD"
    }
}

# データベースの定義
#    - ドキュメント: https://sacloud.github.io/terraform-provider-sakuracloud/configuration/resources/database/
# 注: スイッチ or スイッチ+ルータが必須
resource sakuracloud_database "db" {
    name = "db"

    # データベース種別(postgresql / mariadb)
    database_type = "postgresql"

    # プラン(10g / 30g / 90g / 240g)
    plan = "10g"

    # 管理者パスワード
    admin_password = "${var.db_credentials["admin_password"]}"
    # DBユーザー名
    user_name = "${var.db_credentials["user_name"]}"
    # DBユーザーのパスワード
    user_password = "${var.db_credentials["user_password"]}"

    # 接続を許可するネットワーク or IPアドレス
    #allow_networks = ["192.168.11.0/24","192.168.12.0/24"]

    # ポート番号
    #port = 5432

    # バックアップ開始時刻
    backup_time = "00:00"

    switch_id = "${sakuracloud_internet.router.switch_id}"
    ipaddress1 = "${sakuracloud_internet.router.nw_ipaddresses[0]}"
    nw_mask_len = "${sakuracloud_internet.router.nw_mask_len}"
    default_route = "${sakuracloud_internet.router.nw_gateway}"

    zone = "tk1a"
}

# スイッチ+ルータの定義
resource sakuracloud_internet "router" {
    name = "db_switch"
    zone = "tk1a"
}