# Ubuntu Server Jammy Jellyfish
# ---
# Packer Template to create an Ubuntu Server (Jammy Jellyfish) on Proxmox

# Build Definition to create the VM Template
// build {
//     name = "ubuntu-server-22.04.2"
//     sources = ["source.proxmox-iso.template"]

//     // # Provisioning the VM Template for Cloud-Init Integration in Proxmox #1
//     // provisioner "shell" {
//     //     inline = [
//     //         "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
//     //         "sudo rm /etc/ssh/ssh_host_*",
//     //         "sudo truncate -s 0 /etc/machine-id",
//     //         "sudo apt -y autoremove --purge",
//     //         "sudo apt -y clean",
//     //         "sudo apt -y autoclean",
//     //         "sudo cloud-init clean",
//     //         "sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg",
//     //         "sudo sync"
//     //     ]
//     // }

//     // # Provisioning the VM Template for Cloud-Init Integration in Proxmox #2
//     // provisioner "file" {
//     //     source = "files/99-pve.cfg"
//     //     destination = "/tmp/99-pve.cfg"
//     // }

//     // # Provisioning the VM Template for Cloud-Init Integration in Proxmox #3
//     // provisioner "shell" {
//     //     inline = [ "sudo cp /tmp/99-pve.cfg /etc/cloud/cloud.cfg.d/99-pve.cfg" ]
//     // }

//     # Add additional provisioning scripts here
//     # ...
// }


build {
  sources = ["source.proxmox-iso.template"]

  provisioner "shell" {
    inline = ["while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done", "sudo rm -f /etc/cloud/cloud.cfg.d/99-installer.cfg", "sudo cloud-init clean", "sudo passwd -d ubuntu"]
    only   = ["proxmox"]
  }

}