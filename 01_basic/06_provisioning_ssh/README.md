# Terraform for さくらのクラウド ハンズオン

## 基本編06: プロビジョニング(SSH編)  

作成したサーバにSSH接続し、プロビジョニングを行います。  
今回は例として以下の処理を行います。

  - yumコマンドでApache(httpd)をインストール
  - firewall-cmdコマンドでTCP80番ポートを解放

![基本編06](../images/latest.png "基本編06")

### 解説

terraformのプロビジョニング機能(プロビジョナ)を利用しています。
`terraform apply`実行時に、サーバにSSH接続した上で指定のコマンドを実行します。

#### 動作確認

`terraform output`でサーバのIPを確認し、ブラウザで以下のURLを開いてください。

    http://[サーバのIPアドレス]


## コマンド

* `terraform plan` … 確認
* `terraform apply` … 反映
* `terraform show` … 詳細情報の表示
* `terraform output` … サーバのIPアドレス表示(定義した`output`の表示)
* `terraform destroy` … 環境の破棄


## 参考資料

- [Terraform for さくらのクラウド:リファレンス - サーバ](https://yamamoto-febc.github.io/terraform-provider-sakuracloud/configuration/resources/server/)
- [Terraform for さくらのクラウド:リファレンス - ディスク](https://yamamoto-febc.github.io/terraform-provider-sakuracloud/configuration/resources/disk/)
- [Terraform for さくらのクラウド:リファレンス - 公開鍵](https://yamamoto-febc.github.io/terraform-provider-sakuracloud/configuration/resources/ssh_key/)
- [Terraform for さくらのクラウド:リファレンス - データソース](https://yamamoto-febc.github.io/terraform-provider-sakuracloud/configuration/resources/data_resource/)

---

Next: [基本編07:プロビジョニング(スタートアップスクリプト編)](../07_provisioning_startup_script)