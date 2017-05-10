#----------------------------------------------------------
# 実践編04: Docker + NGINX proxyによるマルチテナントCMS
#----------------------------------------------------------

# さくらのクラウド DNSゾーンの定義
data sakuracloud_dns "zone01" {
    filter {
        name = "Name"
        values = ["${var.dns_target_zone}"]
    }
}

# さくらのクラウド DNSレコードの定義1
resource sakuracloud_dns_record "record01" {
    dns_id = "${data.sakuracloud_dns.zone01.id}"
    name = "${var.dns_record_name01}"
    type = "A"
    value = "${sakuracloud_server.server01.ipaddress}"
}

# ドメインのネームサーバー情報(terraform outputコマンドでの出力用定義)
output "name_server" {
    value = "${data.sakuracloud_dns.zone01.dns_servers}"
}