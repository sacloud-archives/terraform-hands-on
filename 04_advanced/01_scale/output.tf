#----------------------------------------------------------
# 実践編01: スケールアップ/ダウン & スケールアウト/イン
#----------------------------------------------------------

output gslb_fqdn{
    value = "${sakuracloud_gslb.gslb.FQDN}"
}

output resolver_cache_clear_url {
    value = "chrome://net-internals/#dns"
}