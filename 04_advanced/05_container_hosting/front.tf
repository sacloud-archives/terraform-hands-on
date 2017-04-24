#----------------------------------------------------------
# 実践編05:Nomad/Consul/NGINXによるコンテナホスティング
#----------------------------------------------------------

/*****************
 * Disk
 *****************/
resource "sakuracloud_disk" "front" {
  name = "${format("%s%02d" , var.front_disk_name , count.index+1)}"
  source_archive_id = "${data.sakuracloud_archive.centos.id}"
  ssh_key_ids = ["${sakuracloud_ssh_key.key.id}"]
  size = "${var.front_disk_size}"
  disable_pw_auth = true
  zone = "${var.zone}"
  count = "${var.front_count}"
}

/*****************
 * Server
 *****************/
resource "sakuracloud_server" "front" {
  name = "${format("%s%02d" , var.front_server_name , count.index+1)}"
  disks = ["${element(sakuracloud_disk.front.*.id , count.index)}"]
  additional_interfaces = ["${sakuracloud_switch.sw_consul.id}" , "${sakuracloud_switch.sw_front.id}"]
#  packet_filter_ids = [ "${compact(split("," , var.packet_filter_ids))}" ]
  tags = ["@virtio-net-pci","consul","nginx"]
  core = "${var.front_core}"
  memory = "${var.front_memory}"
  zone = "${var.zone}"
  count = "${var.front_count}"

  connection {
    user = "root"
    host = "${self.base_nw_ipaddress}"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "file" {
    source = "provision"
    destination = "/tmp"
  }
  provisioner "file" {
    source = "consul-template"
    destination = "/etc"
  }
  provisioner "file" {
    source = "nginx"
    destination = "/etc"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/provision/*.sh",
      "/tmp/provision/init.sh",
      "/tmp/provision/private_ip.sh eth1 \"${var.front_private_ip_consul[count.index]}\"",
      "/tmp/provision/private_ip.sh eth2 \"${var.front_private_ip_front[count.index]}\"",
      "/tmp/provision/consul.sh ${self.name} ${var.front_private_ip_consul[count.index]} \"\" \"${join(" " , formatlist("-retry-join=%s",var.servers_private_ip_consul))}\"",
      "sed -i -e 's/__YOUR_DOMAIN_NAME__/${var.dns_record_name}.${var.target_domain}/g' /etc/consul-template/virtualhosts.tmpl",
      "/tmp/provision/nginx.sh"
    ]
  }
}

output front_global_ip {
  value = ["${sakuracloud_server.front.*.base_nw_ipaddress}"]
}

