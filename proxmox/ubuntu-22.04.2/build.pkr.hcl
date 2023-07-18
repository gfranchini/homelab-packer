build {
  sources = ["source.proxmox-iso.template"]

  provisioner "shell" {
    inline = ["while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done"]
    only   = ["proxmox"]
  }
}