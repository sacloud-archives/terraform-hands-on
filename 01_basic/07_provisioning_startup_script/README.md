# Terraform for さくらのクラウド ハンズオン

## 基本編07: プロビジョニング(スタートアップスクリプト編) 

さくらのクラウドの`スタートアップスクリプト`機能を利用してプロビジョニングを行います。

![基本編07](../images/latest.png "基本編07")

### 解説

サーバー起動時に`スタートアップスクリプト`を起動してプロビジョニングを行います。

参考: [さくらのクラウド スタートアップスクリプト](http://cloud-news.sakura.ad.jp/startup-script/)


#### スタートアップスクリプトとは

さくらのクラウドの機能の機能で、任意のスクリプトをサーバ起動時に実行するためのものです。  
サーバの起動前に直接ディスクに書き込まれるため、プライベートネットワークに接続していて直接SSH接続できないような環境でも利用可能です。  
また、コメントに特殊タグを埋め込むことで、初回起動時だけ実行する、といった制御も可能です。


## コマンド

* `terraform plan` … 確認
* `terraform apply` … 反映
* `terraform show` … 詳細情報の表示
* `terraform output` … サーバのIPアドレス表示(定義した`output`の表示)
* `terraform destroy` … 環境の破棄

## 参考資料

- [Terraform for さくらのクラウド:リファレンス - サーバ](https://sacloud.github.io/terraform-provider-sakuracloud/configuration/resources/server/)
- [Terraform for さくらのクラウド:リファレンス - ディスク](https://sacloud.github.io/terraform-provider-sakuracloud/configuration/resources/disk/)
- [Terraform for さくらのクラウド:リファレンス - 公開鍵](https://sacloud.github.io/terraform-provider-sakuracloud/configuration/resources/ssh_key/)
- [Terraform for さくらのクラウド:リファレンス - スタートアップスクリプト](https://sacloud.github.io/terraform-provider-sakuracloud/configuration/resources/note/)
- [Terraform for さくらのクラウド:リファレンス - データソース](https://sacloud.github.io/terraform-provider-sakuracloud/configuration/resources/data_resource/)

---

Next: [基本編08:変数の利用(変数 + tfvarsファイル)](../08_use_variables)