#----------------------------------------------------------
# 実践編05:Nomad/Consul/NGINXによるコンテナホスティング
#----------------------------------------------------------

#************************************************
# 共通設定
#************************************************

# 対象ドメイン名
# 設定例:
# variable "target_domain" {
#     default = "nomad.example.com"
# }
variable "target_domain" { default = "example.com" }
variable "dns_record_name" {
    default = "nomad"
}


# 作成対象ゾーン(is1b:石狩第2、tk1a:東京第1)
variable "zone"{
    default = "is1b"
}

#************************************************
# Nomadサーバーの設定
#************************************************
# 基本スペック
variable "servers_server_name" {default = "servers"}
variable "servers_disk_name" {default = "servers"}
variable "servers_disk_size" { default = "20"}
variable "servers_core" { default = "1" }
variable "servers_memory" { default = "1" }

# マシン台数/各マシンのIP
variable "servers_count" {default = "3"}
variable servers_private_ip_consul {
    default = ["192.168.10.11", "192.168.10.12", "192.168.11.13"]
}
variable servers_private_ip_nomad {
    default = ["192.168.20.11", "192.168.20.12", "192.168.20.13"]
}

#************************************************
# Nomadエージェントの設定
#************************************************
# 基本スペック
variable "agents_server_name" {default = "agents"}
variable "agents_disk_name" {default = "agents"}
variable "agents_disk_size" { default = "20"}
variable "agents_core" { default = "1" }
variable "agents_memory" { default = "1" }

# マシン台数/各マシンのIP
variable "agents_count" {default = "3"}
variable agents_private_ip_consul {
    default = ["192.168.10.101", "192.168.10.102", "192.168.10.103"]
}
variable agents_private_ip_nomad {
    default = ["192.168.20.101", "192.168.20.102", "192.168.20.103"]
}
variable agents_private_ip_front {
    default = ["192.168.30.101", "192.168.30.102", "192.168.30.103"]
}

#************************************************
# フロントエンド(Nginx)の設定
#************************************************
# 基本スペック
variable "front_server_name" {default = "front"}
variable "front_disk_name" {default = "front"}
variable "front_disk_size" { default = "20"}
variable "front_core" { default = "1" }
variable "front_memory" { default = "1" }

# マシン台数/各マシンのIP
variable "front_count" {default = "2"}

variable front_private_ip_consul {
    default = ["192.168.10.201", "192.168.10.202"]
}

variable front_private_ip_front {
    default = ["192.168.30.201", "192.168.30.202"]
}
