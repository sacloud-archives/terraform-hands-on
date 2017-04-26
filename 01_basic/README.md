# Terraform for さくらのクラウド ハンズオン

## 基本編

基本編では、さくらのクラウド上でのサーバ作成を通じて以下のような内容を扱います。

  - tfファイルの基本的な構文
  - 他のリソースの参照方法(`${リソースタイプ.リソースID.属性}`記法)
  - データソースの利用方法
  - さくらのクラウドでのサーバ関連リソースの扱い
  - プロビジョニング(SSH)
  - プロバイダ固有のプロビジョニング方法(さくらのクラウドの場合はスタートアップスクリプト)
  - 変数の定義 + 変数への値設定方法

## - 目次 -

| No.| タイトル                        | コンテンツ           |
|:---:|---------------------------|-------------------|
| 01 |空(ディスクレス)のサーバを作成   | [01_create_server](01_create_server) |
| 02 |ディスクの作成〜サーバとの接続   | [02_create_disk](02_create_disk) |
| 03 |OSのインストール               | [03_install_os](03_install_os) |
| 04 |データソースの利用             | [04_use_data_source](04_use_data_source) |
| 05 |SSH公開鍵認証の導入                       | [05_use_ssh_key](05_use_ssh_key) |
| 06 |プロビジョニング(SSH編)                   | [06_provisioning_ssh](06_provisioning_ssh) |
| 07 |プロビジョニング(スタートアップスクリプト編)  | [07_provisioning_startup_script](07_provisioning_startup_script) |
| 08 |変数の利用(変数 + tfvarsファイル)    | [08_use_variables](08_use_variables) |

#### 基本編で扱うリソースの構成図

![基本編のリソース構成図](images/latest.png "基本編のリソース構成図")