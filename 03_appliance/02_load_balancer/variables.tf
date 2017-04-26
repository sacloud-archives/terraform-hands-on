#----------------------------------------------------------
# 応用リソース(アプライアンス)編02: ロードバランサ
#----------------------------------------------------------

# パスワード
variable password {
    default = "PUT_YOUR_PASSWORD_HERE"
}

# SSH秘密鍵のパス
variable key_path {
    type = "map"
    default = {
        private_key = "~/.ssh/id_rsa"
        public_key = "~/.ssh/id_rsa.pub"
    }
}