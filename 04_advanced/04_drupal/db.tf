#----------------------------------------------------------
# 実践編04: Docker + NGINX proxyによるマルチテナントCMS
#----------------------------------------------------------

resource "sakuracloud_database" "db" {
    # さくらのクラウド上でのリソース名称
    name = "${var.db_name}"

    # 管理者(postgres)パスワード
    admin_password = "${var.db_admin_password}"

    # ユーザーの名前/パスワード
    user_name = "${var.db_user_name}"
    user_password = "${var.db_user_password}"

    # 取得時間
    backup_time = "00:00"

    switch_id = "${sakuracloud_internet.router.switch_id}"
    ipaddress1 = "${sakuracloud_internet.router.ipaddresses[0]}"
    nw_mask_len = "${sakuracloud_internet.router.nw_mask_len}"
    default_route = "${sakuracloud_internet.router.gateway}"

}

# postgresへの接続方法を定義
provider "postgresql" {
    host = "${sakuracloud_database.db.ipaddress1}"
    port = "${sakuracloud_database.db.port}"
    username = "${var.db_user_name}"
    password = "${var.db_user_password}"
    sslmode = "disable"
}

# データベース定義
resource "postgresql_database" "drupal" {
    count = 20
    owner = "drupal"
    name = "${format("drupal%02d" , count.index+1)}"
}

# スイッチ+ルータの定義
resource sakuracloud_internet "router" {
    name = "db_switch"
    zone = "tk1a"
}