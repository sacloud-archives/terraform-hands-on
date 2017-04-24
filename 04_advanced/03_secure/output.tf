#----------------------------------------------------------
# 実践編03: ロードバランサ + セキュアなDB接続環境 + VPC
#----------------------------------------------------------

#--------------------------------------
# アウトプットの定義
#--------------------------------------
# WebサーバへのSSH接続コマンド
output "ssh_to_web" {
    value = "${
        zipmap(
            sakuracloud_server.web_servers.*.name, 
            formatlist("ssh -i ~/.ssh/id_rsa root@%s", sakuracloud_server.web_servers.*.base_nw_ipaddress)
        )
    }"
}

# DBサーバへのSSH接続コマンド(VPN接続必須)
output "ssh_to_db" {
    value = "${
        zipmap(
            sakuracloud_server.db_servers.*.name, 
            formatlist("ssh -i ~/.ssh/id_rsa root@%s", sakuracloud_server.db_servers.*.base_nw_ipaddress)
        )
    }"
}

# GSLBのFQDN
# 本来はロードバランシングしたいホスト名のCNAMEレコードとしてDNSの登録するもの
output "gslb_url" {
    value = "http://${sakuracloud_gslb.gslb.FQDN}"
}