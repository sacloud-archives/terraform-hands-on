# Terraform for さくらのクラウド ハンズオン

## 応用リソース(サービス)編02: シンプル監視

外部監視(外形監視)機能を提供します。

ping/tcp/http/httpsなど各種プロトコルでの監視に対応しています。  
障害発生時の通知はメールとSlackが利用可能です。  

参考: [さくらのクラウド シンプル監視](http://cloud-news.sakura.ad.jp/simplemonitor/)

## 解説

監視対象は以下の変数で指定します。任意のホスト(FQDN)またはIPアドレスを指定してください。

```hcl
# 監視対象のIPアドレス(or FQDN)定義
variable target_host {
    default = "example.com"
}
```

## コマンド

* `terraform plan` … 確認
* `terraform apply` … 反映
* `terraform show` … 詳細情報の表示
* `terraform destroy` … 環境の破棄

## 参考資料

- [Terraform for さくらのクラウド:リファレンス - シンプル監視](https://sacloud.github.io/terraform-provider-sakuracloud/configuration/resources/simple_monitor/)

---

Next: [応用リソース(サービス)編03:DNS ](../03_dns)