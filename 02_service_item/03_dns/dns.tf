#----------------------------------------------------------
# 応用リソース(サービス)編03: DNS
#----------------------------------------------------------

# 対象ゾーン名
variable target {
    default = {
        zone_name = "example.com"
        ipaddr = "192.0.2.1"
        txt = "v=spf1 +mx ~all"
    }
}

# DNS(ゾーン)の定義
resource "sakuracloud_dns" "dns" {
    zone = "${var.target["zone_name"]}"
}

# DNS(Aレコード)の定義
resource "sakuracloud_dns_record" "record_a" {
    # レコードを登録するゾーンのID
    dns_id = "${sakuracloud_dns.dns.id}"

    # レコード名(ホスト名など、@を指定すると該当ゾーンを示す)
    name = "@"
    # レコード種別(A/AAAA/NS/CNAME/MX/TXT/SRV)
    type = "A"
    # 値
    value = "${var.target["ipaddr"]}"
}

# DNS(MXレコード)の定義
resource "sakuracloud_dns_record" "record_mx" {
    # レコードを登録するゾーンのID
    dns_id = "${sakuracloud_dns.dns.id}"

    # レコード名(ホスト名など、@を指定すると該当ゾーンを示す)
    name = "@"
    # レコード種別(A/AAAA/NS/CNAME/MX/TXT/SRV)
    type = "MX"
    # 値
    value = "${var.target["zone_name"]}."
}

# DNS(TXTレコード)の定義
resource "sakuracloud_dns_record" "record_txt" {
    # レコードを登録するゾーンのID
    dns_id = "${sakuracloud_dns.dns.id}"

    # レコード名(ホスト名など、@を指定すると該当ゾーンを示す)
    name = "@"
    # レコード種別(A/AAAA/NS/CNAME/MX/TXT/SRV)
    type = "TXT"
    # 値
    value = "${var.target["txt"]}"
}

