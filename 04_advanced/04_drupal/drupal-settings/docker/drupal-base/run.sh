#!/bin/bash

/tmp/wait-for-it.sh ${DB_HOST}:5432

if [ -n "$DEBUG" ]; then
  echo "waiting for database init..."
  sleep 20s
  echo "done"
fi

if [ -n "`drush status drupal-settings-file | grep MISSING`" ] ; then
    # Drupalサイトをインストール
    drush -y si \
      --db-url=pgsql://${DB_USER_NAME}:${DB_USER_PASSWORD}@${DB_HOST}/${DRUPAL_HOSTNAME} \
      --locale=ja \
      --account-name=${DRUPAL_ACCOUNT_NAME} \
      --account-pass=${DRUPAL_ACCOUNT_PASSWORD} \
      --account-mail=${DRUPAL_ACCOUNT_MAIL} \
      --db-prefix=${DRUPAL_HOSTNAME} \
      --site-name=${DRUPAL_HOSTNAME} \
      standard install_configure_form.update_status_module='array(FALSE,FALSE)'

    # Drupal をローカライズするためのモジュールを有効化
    drush -y en locale

    # 日本のロケール設定
    drush -y vset site_default_country JP
    drush eval "locale_add_language('ja', 'Japanese', '日本語');"
    drush eval '$langs = language_list(); variable_set("language_default", $langs["ja"])'

    # 最新の日本語ファイルを取り込むモジュールをダウンロードしてインストール
    drush -y dl l10n_update
    drush -y en l10n_update

    # 最新の日本語情報を取得してインポート
    drush l10n-update-refresh
    drush l10n-update

    cat << 'EOF' >>  /var/www/html/sites/default/settings.php
    $conf['drupal_http_request_fails'] = FALSE;
EOF

    # webformのダウンロード & 有効化
    drush -y dl webform
    drush -y en webform

    # ******** 必要なモジュールやテーマがあればここに記載
    # === サンプル
    # drush -y dl cck zen # CCKモジュールとzenテーマをダウンロード
    # drush -y en cck     # CCKモジュールを有効化
    # drush -y en zen     # zenテーマを有効化
    # drush -y vset theme_default zen  # Zen テーマをデフォルトに設定
    # === ここまで

    # Drupal のルートディレクトリ (/var/www/html) 以下の所有者を apache に変更
    chown -R www-data: /var/www/html || exit 1
fi

# apacheをフォアグラウンド起動
apache2-foreground