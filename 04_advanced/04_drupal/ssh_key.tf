#----------------------------------------------------------
# 実践編03: ロードバランサ + セキュアなDB接続環境 + VPC
#----------------------------------------------------------

#--------------------------------------
# SSH公開鍵の定義
#--------------------------------------

# SSH公開鍵の定義
resource "sakuracloud_ssh_key" "key" {
    name = "key"
    public_key = "${file("~/.ssh/id_rsa.pub")}"
}