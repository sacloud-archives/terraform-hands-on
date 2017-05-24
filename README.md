# Terraform for さくらのクラウド ハンズオン

Terraform for さくらのクラウドを利用したハンズオンの資料です。  

## 目次

### [準備編](00_introduction/README.md)

| No.| タイトル                      | コンテンツ           |
|:---:| -------------------------- | ------------------- |
| -  | 作業用サーバの構築,ハンズオンの進め方 | [00_introduction](00_introduction/README.md) |


### [基本編](01_basic/README.md)

| No.| タイトル                        | コンテンツ           |
|:---:|---------------------------|-------------------|
| 01 |空(ディスクレス)のサーバを作成   | [01_basic/01_create_server](01_basic/01_create_server) |
| 02 |ディスクの作成〜サーバとの接続   | [01_basic/02_create_disk](01_basic/02_create_disk) |
| 03 |OSのインストール               | [01_basic/03_install_os](01_basic/03_install_os) |
| 04 |データソースの利用             | [01_basic/04_use_data_source](01_basic/04_use_data_source) |
| 05 |SSH公開鍵認証の導入                       | [01_basic/05_use_ssh_key](01_basic/05_use_ssh_key) |
| 06 |プロビジョニング(SSH編)                   | [01_basic/06_provisioning_ssh](01_basic/06_provisioning_ssh) |
| 07 |プロビジョニング(スタートアップスクリプト編)  | [01_basic/07_provisioning_startup_script](01_basic/07_provisioning_startup_script) |
| 08 |変数の利用(変数 + tfvarsファイル)    | [01_basic/08_use_variables](01_basic/08_use_variables) |

### [応用リソース(サービス)編](02_service_item/README.md)

| No.| タイトル                      | コンテンツ           |
|:---:|---------------------------|---------------------|
| 01 | 自動バックアップ            | [02_service_item/01_auto_backup](02_service_item/01_auto_backup) |
| 02 | シンプル監視               | [02_service_item/02_simple_monitor](02_service_item/02_simple_monitor) |
| 03 | DNS                      | [02_service_item/03_dns](02_service_item/03_dns) |
| 04 | GSLB(広域負荷分散)         | [02_service_item/04_gslb](02_service_item/04_gslb) |

### [応用リソース(アプライアンス)編](03_appliance/README.md)

| No.| タイトル                      | コンテンツ           |
|:---:|---------------------------|---------------------|
| 01 | データベースアプライアンス   | [03_appliance/01_database](03_appliance/01_database) |
| 02 | ロードバランサ             | [03_appliance/02_load_balancer](03_appliance/02_load_balancer) |
| 03 | VPCルータ                 | [03_appliance/03_vpc_router](03_appliance/03_vpc_router) |

### [実践編](04_advanced/README.md)

| No.| タイトル                      | コンテンツ           |
|:---:|---------------------------|---------------------|
| 01 | スケーリング(up/down, out/in) | [04_advanced/01_scale](04_advanced/01_scale) |
| 02 | マルチプロバイダ(さくらのクラウド+Arukas)| [04_advanced/02_multi_provider](04_advanced/02_multi_provider) |
| 03 | ロードバランサ + セキュアなDB接続環境 + VPC | [04_advanced/03_secure](04_advanced/03_secure) |
| 04 | (**上級者向け**)Docker + NGINX proxyによるマルチテナントCMS | [04_advanced/04_drupal](04_advanced/04_drupal) |
| 05 | (**上級者向け**)Nomad/Consul/NGINXによるスケーラブルなコンテナホスティング | [04_advanced/05_container_hosting](04_advanced/05_container_hosting) |

## 参考資料

### リファレンス

* Terraform 組み込み関数
    * [https://www.terraform.io/docs/configuration/interpolation.html#built-in-functions](https://www.terraform.io/docs/configuration/interpolation.html#built-in-functions)
* Terraform コマンドリファレンス
    * [https://www.terraform.io/docs/commands/index.html](https://www.terraform.io/docs/commands/index.html)
* Terraform 組み込みプロバイダ
    * [https://www.terraform.io/docs/providers/index.html](https://www.terraform.io/docs/providers/index.html)
* Terraform for さくらのクラウド リファレンス
    * [https://sacloud.github.io/terraform-provider-sakuracloud/](https://sacloud.github.io/terraform-provider-sakuracloud/)

### プロダクト

* Terraform
    * [https://www.terraform.io/](https://www.terraform.io/)
* Terraform for さくらのクラウド
    * [https://github.com/sacloud/terraform-provider-sakuracloud](https://github.com/sacloud/terraform-provider-sakuracloud)

### 紹介記事

* Terraform for さくらのクラウド スタートガイド （第1回） ～インストールから基本操作 ～ 
    * [http://knowledge.sakura.ad.jp/knowledge/7230/](http://knowledge.sakura.ad.jp/knowledge/7230/)  
* Terraform for さくらのクラウド スタートガイド （第2回） ～便利なビルトイン機能～ 
    * [http://knowledge.sakura.ad.jp/knowledge/7550/](http://knowledge.sakura.ad.jp/knowledge/7550/)
* Terraform for さくらのクラウド スタートガイド （第3回）〜さくらのクラウド上にインフラ構築〜
    * [http://knowledge.sakura.ad.jp/knowledge/7660/](http://knowledge.sakura.ad.jp/knowledge/7660/)
* Terraform for さくらのクラウド スタートガイド （第4回）〜ネットワークの構築〜
    * [http://knowledge.sakura.ad.jp/knowledge/8248/](http://knowledge.sakura.ad.jp/knowledge/8248/)
* Terraform for さくらのクラウド スタートガイド （第5回）〜サービス提供用のリソースと応用編〜
    * [http://knowledge.sakura.ad.jp/knowledge/8581/](http://knowledge.sakura.ad.jp/knowledge/8581/)
    
* Terraform for Sakura Cloud ハンズオン資料(@zembutsuさん)
    * [https://github.com/zembutsu/sakura-terraform](https://github.com/zembutsu/sakura-terraform)
* Terraform for さくらのクラウド入門チュートリアル(@zembutsuさん)
    * [http://qiita.com/zembutsu/items/fb0819e38b4fcda49299](http://qiita.com/zembutsu/items/fb0819e38b4fcda49299)

### 実例/サンプルなど

* teratailのさくらのクラウド チュートリアルの構成を「Terraform for さくらのクラウド」で構築するためのtfファイル集
    * [https://github.com/sacloud/teratail-sakuracloud-terraform-examples](https://github.com/sacloud/teratail-sakuracloud-terraform-examples)

## License

 `terraform-hands-on` Copyright (C) 2017 Kazumichi Yamamoto.

  This project is published under [Apache 2.0 License](LICENSE.txt).
  
## Author

  * Kazumichi Yamamoto ([@yamamoto-febc](https://github.com/sacloud))