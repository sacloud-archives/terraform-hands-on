#----------------------------------------------------------
# 応用リソース(サービス)編04: GSLB
#----------------------------------------------------------

# GSLBの定義
#   - ドキュメント: https://yamamoto-febc.github.io/terraform-provider-sakuracloud/configuration/resources/gslb/
resource "sakuracloud_gslb" "gslb" {
    name = "service_item04_gslb"
    # ヘルスチェック方法の定義
    health_check = {
        # 死活監視で用いるプロトコル
        protocol = "http"

        # 監視間隔(秒数)
        delay_loop = 10

        # http/httpsの場合のリクエストパス
        path = "/"

        # http/httpsの場合の期待するレスポンスコード
        status = "200"
    }
}

# GSLB配下のサーバ定義
resource "sakuracloud_gslb_server" "gslb_servers" {
    count = "${var.server_count}"
    gslb_id = "${sakuracloud_gslb.gslb.id}"
    ipaddress = "${sakuracloud_server.servers.*.base_nw_ipaddress[count.index]}"
}

# GSLBに割り当てられたFQDN
output gslb_fqdn {
    value = "${sakuracloud_gslb.gslb.FQDN}"
}

# 本来は以下のようにDNS(CNAME)と組み合わせて使う
# 以下の例だと"http://service.example.com"にアクセスすることになる
/*
# DNS(ゾーン)の定義
resource "sakuracloud_dns" "dns" {
    zone = "example.com"
}
# DNS(CNAMEレコード)の定義
resource "sakuracloud_dns_record" "record_cname" {
    # レコードを登録するゾーンのID
    dns_id = "${sakuracloud_dns.dns.id}"

    # レコード名
    name = "service"
    # レコード種別(A/AAAA/NS/CNAME/MX/TXT/SRV)
    type = "CNAME"
    # 値
    value = "${sakuracloud_gslb.gslb.FQDN}."
}
*/