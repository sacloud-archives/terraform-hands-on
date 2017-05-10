#----------------------------------------------------------
# 実践編05:Nomad/Consul/NGINXによるコンテナホスティング
#----------------------------------------------------------

/*****************
 * Disk
 *****************/
resource sakuracloud_disk "agents" {
    name = "${format("%s%02d" , var.agents_disk_name , count.index+1)}"
    source_archive_id = "${data.sakuracloud_archive.centos.id}"
    ssh_key_ids = ["${sakuracloud_ssh_key.key.id}"]
    size = "${var.agents_disk_size}"
    disable_pw_auth = true
    zone = "${var.zone}"
    count = "${var.agents_count}"
}

/*****************
 * Server
 *****************/
resource sakuracloud_server "agents" {
    name = "${format("%s%02d" , var.agents_server_name , count.index+1)}"
    disks = ["${sakuracloud_disk.agents.*.id[count.index]}"]
    additional_nics = ["${sakuracloud_switch.sw_consul.id}" , "${sakuracloud_switch.sw_nomad.id}" , "${sakuracloud_switch.sw_front.id}"]
    tags = ["@virtio-net-pci","consul","nomad"]
    core = "${var.agents_core}"
    memory = "${var.agents_memory}"
    zone = "${var.zone}"
    count = "${var.agents_count}"

    connection {
      user = "root"
      host = "${self.ipaddress}"
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
        "/tmp/provision/private_ip.sh eth1 \"${var.agents_private_ip_consul[count.index]}\"",
        "/tmp/provision/private_ip.sh eth2 \"${var.agents_private_ip_nomad[count.index]}\"",
        "/tmp/provision/private_ip.sh eth3 \"${var.agents_private_ip_front[count.index]}\"",
        "/tmp/provision/consul.sh ${self.name} ${var.agents_private_ip_consul[count.index]} \"\" \"${join(" " , formatlist("-retry-join=%s",var.servers_private_ip_consul))}\"",
        "/tmp/provision/docker.sh",
        "/tmp/provision/nomad.sh ${self.name} ${var.agents_private_ip_nomad[count.index]} \"\" ''"
      ]
    }
}

output agents_global_ip {
    value = ["${sakuracloud_server.agents.*.ipaddress}"]
}