#----------------------------------------------------------
# 実践編03: ロードバランサ + セキュアなDB接続環境 + VPC
#----------------------------------------------------------

#--------------------------------------
# ネットワークの定義
#--------------------------------------

# スイッチ
resource sakuracloud_switch "switch" {
    name = "switch"
    bridge_id = "${sakuracloud_bridge.bridge.id}"

    count = 2
    zone = "${var.switch_zones[count.index]}"
}

# ブリッジ
resource sakuracloud_bridge "bridge" {
    name = "bridge"
}