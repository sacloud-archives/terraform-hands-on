# 変数設定
server_name = "server_scaling"
password = "PUT_YOUR_PASSWORD_HERE"

# サーバ数(GSLBを利用する場合は1~6)
server_count = 2   # 2~6に変更

# サーバスペック
#   指定可能な値は以下のページを参照
#   http://cloud.sakura.ad.jp/specification/server-disk/
server_spec = {
    core = 1     # 2に変更する
    memory = 1   # 4に変更する
}


#key_path = {
#  private_key = "~/.ssh/id_rsa"
#  public_key = "~/.ssh/id_rsa.pub"
#}