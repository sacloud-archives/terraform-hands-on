#----------------------------------------------------------
# 実践編05:Nomad/Consul/NGINXによるコンテナホスティング
#----------------------------------------------------------

# さくらのクラウド DNSゾーンの定義
data sakuracloud_dns "zone" {
    filter {
        name = "Name"
        values = ["${var.target_domain}"]
    }
}

# さくらのクラウド DNSレコードの定義(ワイルドカード)
resource sakuracloud_dns_record "record" {
    count = "${var.front_count}"
    dns_id = "${data.sakuracloud_dns.zone.id}"
    name = "*.${var.dns_record_name}"
    type = "A"
    value = "${sakuracloud_server.front.*.base_nw_ipaddress[count.index]}"
}

# ドメインのネームサーバー情報(terraform outputコマンドでの出力用定義)
output "name_server" {
    value = "${data.sakuracloud_dns.zone.dns_servers}"
}