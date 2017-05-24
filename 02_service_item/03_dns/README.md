# Terraform for さくらのクラウド ハンズオン

## 応用リソース(サービス)編03: DNS

DNSサーバ機能を提供します。

参考: [さくらのクラウド DNS](http://cloud-news.sakura.ad.jp/cloud_dns/)

## 解説

対象ゾーンは以下の変数で指定します。所有しているドメイン名に置き換えてください。

```hcl
# 対象ゾーン名
variable target {
    default = {
        zone_name = "example.com"
        ipaddr = "192.0.2.1"
        txt = "v=spf1 +mx ~all"
    }
}
```

## コマンド

* `terraform plan` … 確認
* `terraform apply` … 反映
* `terraform show` … 詳細情報の表示
* `terraform destroy` … 環境の破棄

## 参考資料

- [Terraform for さくらのクラウド:リファレンス - DNS](https://sacloud.github.io/terraform-provider-sakuracloud/configuration/resources/dns/)

---

Next: [応用リソース(サービス)編04:GSLB(広域負荷分散) ](../04_gslb)