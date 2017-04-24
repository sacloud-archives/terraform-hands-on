#----------------------------------------------------------
# 実践編04: Docker + NGINX proxyによるマルチテナントCMS
#----------------------------------------------------------

# サーバー設定

# サーバー管理者(root)のパスワード
variable server_password { default = "TestUserPassword01" }
# ディスクプラン(hdd または ssd)
variable disk_plan { default = "hdd"}
# サーバーのディスクサイズ(GB単位)
variable disk_size { default = 60 }

# さくらのクラウド DNS設定

# DNSゾーン名
variable dns_target_zone { default = "example.com" }
# DNSレコード1
variable dns_record_name01 { default = "*" }

/******************************************************************************
 * さくらのクラウド データーベース設定
 *****************************************************************************/

# データベース名
variable db_name { default = "drupal" }
# データベース 管理者パスワード
variable db_admin_password { default = "TestUserPassword01" }
# データベース ユーザー名
variable db_user_name { default = "drupal" }
# データベース ユーザーパスワード
variable db_user_password { default = "TestUserPassword01" }

/******************************************************************************
 * Drupal設定
 *****************************************************************************/
# Drupal 管理者アカウント名
variable drupal_account_name { default = "admin" }
# Drupal 管理者パスワード
variable drupal_account_password { default = "TestUserPassword01" }
# Drupal 管理者メールアドレス
variable drupal_account_mail { default = "example@example.jp" }
