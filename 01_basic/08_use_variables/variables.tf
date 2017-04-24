#----------------------------------------------------------
# 基本編08: 変数の利用(変数 + tfvarsファイル)
#----------------------------------------------------------

# 変数定義

# サーバ名
variable server_name {
    default = "YOUR_SERVER_NAME"
}

# パスワード
variable password {}

# SSH秘密鍵のパス
variable key_path {
    type = "map"
    default = {
        private_key = "~/.ssh/id_rsa"
        public_key = "~/.ssh/id_rsa.pub"
    }
}