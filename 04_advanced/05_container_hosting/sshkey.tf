#----------------------------------------------------------
# 実践編05:Nomad/Consul/NGINXによるコンテナホスティング
#----------------------------------------------------------

resource "sakuracloud_ssh_key" "key" {
    name = "sshkey"
    public_key = "${file("~/.ssh/id_rsa.pub")}"
}
