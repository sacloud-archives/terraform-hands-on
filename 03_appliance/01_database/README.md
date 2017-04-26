# Terraform for さくらのクラウド ハンズオン

## 応用リソース(アプライアンス)編01: データベースアプライアンス

データベース(RDB)をアプライアンスとして提供します。  
PostgreSQLとMariaDBがサポートされています。

参考: [さくらのクラウド データベースアプライアンス](http://cloud-news.sakura.ad.jp/database/)

## 解説

データベースアプライアンスを利用するには、スイッチ or スイッチ+ルータが必要です。  
今回はスイッチ+ルータを利用し、グローバルIPをデータベースアプライアンスに割り当てています。

## 動作確認

コントロールパネルからWebUIを有効化するとphpPgAdmin(PostgreSQL)、またはphpMyAdmin(MariaDB)が利用可能です。

## コマンド

* `terraform plan` … 確認
* `terraform apply` … 反映
* `terraform show` … 詳細情報の表示
* `terraform destroy` … 環境の破棄

## 参考資料

- [Terraform for さくらのクラウド:リファレンス - データベース](https://yamamoto-febc.github.io/terraform-provider-sakuracloud/configuration/resources/database/)
- [Terraform for さくらのクラウド:リファレンス - スイッチ+ルータ](https://yamamoto-febc.github.io/terraform-provider-sakuracloud/configuration/resources/internet/)

---

Next: [応用リソース(アプライアンス)編02:ロードバランサ ](../02_load_balancer)