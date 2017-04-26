#----------------------------------------------------------
# 実践編02: マルチプロバイダ(さくらのクラウド + Arukas)
#----------------------------------------------------------

# 事前にArukasのAPIキーを以下環境変数に設定しておく必要があります。
# Arukas: https://arukas.io/
#    - ARUKAS_JSON_API_TOKEN
#    - ARUKAS_JSON_API_SECRET

# Arukas上のコンテナ(NGINX)
resource "arukas_container" "ct" {
    name = "arukas-with-simple-monitor"
    image = "nginx:latest"
    ports = {
        protocol = "tcp"
        number = "80"
    }
}

# シンプル監視
resource "sakuracloud_simple_monitor" "demo_monitor" {

    # 監視対象(Arukas側で割り当てられたエンドポイント(FQDN)を指定)
    target = "${arukas_container.ct.endpoint_full_hostname}"

    # 監視方法(https)
    health_check = {
        protocol = "https"
        path = "/"
        status = 200
    }
}