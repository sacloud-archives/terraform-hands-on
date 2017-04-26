#----------------------------------------------------------
# 応用リソース(サービス)編04: GSLB
#----------------------------------------------------------

# 変数定義

# サーバ名
variable server_name {
    default = "YOUR_SERVER_NAME"
}

# サーバ数
variable server_count {
    default = 3
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