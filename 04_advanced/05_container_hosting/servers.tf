#----------------------------------------------------------
# 実践編05:Nomad/Consul/NGINXによるコンテナホスティング
#----------------------------------------------------------

/*****************
 * Disk
 *****************/
resource "sakuracloud_disk" "servers" {
  name = "${format("%s%02d" , var.servers_disk_name , count.index+1)}"
  source_archive_id = "${data.sakuracloud_archive.centos.id}"
  ssh_key_ids = ["${sakuracloud_ssh_key.key.id}"]
  size = "${var.servers_disk_size}"
  disable_pw_auth = true
  zone = "${var.zone}"
  count = "${var.servers_count}"
}

/*****************
 * Server
 *****************/
resource "sakuracloud_server" "servers" {
  name = "${format("%s%02d" , var.servers_server_name , count.index+1)}"
  disks = ["${sakuracloud_disk.servers.*.id[count.index]}"]
  additional_interfaces = ["${sakuracloud_switch.sw_consul.id}" , "${sakuracloud_switch.sw_nomad.id}"]
#  packet_filter_ids = [ "${compact(split("," , var.packet_filter_ids))}" ]
  tags = ["@virtio-net-pci","consul","nomad"]
  core = "${var.servers_core}"
  memory = "${var.servers_memory}"
  zone = "${var.zone}"
  count = "${var.servers_count}"

  connection {
    user = "root"
    host = "${self.base_nw_ipaddress}"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "file" {
    source = "${path.root}/provision"
    destination = "/tmp"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/provision/*.sh",
      "/tmp/provision/init.sh",
      "/tmp/provision/private_ip.sh eth1 \"${var.servers_private_ip_consul[count.index]}\"",
      "/tmp/provision/private_ip.sh eth2 \"${var.servers_private_ip_nomad[count.index]}\"",
      "/tmp/provision/consul.sh ${self.name} ${var.servers_private_ip_consul[count.index]} ${var.servers_count} \"${join(" " , formatlist("-retry-join=%s",var.servers_private_ip_consul))}\" 1",
      "/tmp/provision/docker.sh",
      "/tmp/provision/nomad.sh ${self.name} ${var.servers_private_ip_nomad[count.index]} ${var.servers_count} '${join("," , formatlist("%q",var.servers_private_ip_nomad))}' 1"
    ]
  }

  provisioner "file" {
    source = "${path.root}/nomad_sample"
    destination = "/root"
  }
}

output server_global_ip {
    value = ["${sakuracloud_server.servers.*.base_nw_ipaddress}"]
}