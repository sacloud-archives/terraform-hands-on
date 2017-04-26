#----------------------------------------------------------
# 応用リソース(サービス)編02: シンプル監視
#----------------------------------------------------------

# 監視対象のIPアドレス(or FQDN)定義
variable target_host {
    default = "sacloud.github.io"
}

# シンプル監視の定義
resource sakuracloud_simple_monitor "monitor" {
    # 監視対象(IPアドレス or ホスト名)
    # なお、さくらインターネットのIPアドレスを指定すれば無料で監視できる(VPSや専用サーバもOK)
    target = "${var.target_host}"

    # 監視方法
    health_check = {
        # 監視で用いるプロトコル(http/https/ping/tcp/ssh/smtp/pop3/dns/snmpなど)
        protocol = "https"

        # チェック間隔(秒数): 60 ~ 3600
        delay_loop = 60

        # http/httpsの場合のリクエストパス
        path = "/"

        # http/httpsの場合のリクエスト時ホストヘッダ
        # VirtualHostの監視などで利用する
        #host_header = "example.com"

        # http/httpsの場合の期待するレスポンスコード
        status = "200"
    }

    # e-mailによる通知の有効化
    #   - メンテナンス・障害情報通知先に登録されているメールアドレス宛に通知されます。
    #   - 登録がない場合は、会員IDに紐付いているメールアドレス宛に通知されます
    notify_email_enabled = true

    # e-mailによる通知時、htmlメールの有効化
    # notify_email_html = true

    # slack(webhook)による通知の有効化
    # notify_slack_enabled = true

    # slackのIncoming WebHooksのURL
    # notify_slack_webhook = "https://hooks.slack.com/services/XXXXXXXXX/XXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXX"
}

