source "proxmox-iso" "template" {

  proxmox_url              = "${var.proxmox_api_url}"
  username                 = "${var.proxmox_api_token_id}"
  token                    = "${var.proxmox_api_token_secret}"
  insecure_skip_tls_verify = true

  node                 = "pve"
  vm_id                = "1000"
  vm_name              = "ubuntu-server-22.04.2-packer-template"
  template_description = "Ubuntu server 22.04.2 template with the default configuration generated by Packer on {{ isotime `2006-01-02` }}."

  # VM OS Settings
  os               = "l26"
  iso_file         = "local:iso/ubuntu-22.04.2-live-server-amd64.iso"
  iso_storage_pool = "local"
  unmount_iso      = true

  # VM System Settings
  qemu_agent = true

  # VM Hard Disk Settings
  scsi_controller = "virtio-scsi-single"

  disks {
    disk_size    = "32G"
    format       = "raw"
    storage_pool = "local-zfs"
    type         = "virtio"
    io_thread    = true
  }

  # VM CPU Settings
  cores = "2"

  # VM Memory Settings
  memory = "2048"

  # VM Network Settings
  network_adapters {
    model    = "virtio"
    bridge   = "vmbr0"
    firewall = "false"
  }

  # VM Cloud-Init Settings
  cloud_init              = true
  cloud_init_storage_pool = "local-zfs"

  boot_wait = "10s"

  # The boot command only works if I set the filepath to a var for some reason. Otherwise it's not fully typed out...
  boot_command = [
    "c",
    "file=/casper/initrd<enter>",
    "linux /casper/vmlinuz -- autoinstall ds='nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/'",
    "<enter><wait><wait>",
    "initrd $file",
    "<enter><wait><wait>",
    "boot<enter>"
  ]

  # PACKER Autoinstall Settings
  http_directory = "http"
  ssh_username   = "gfranchini"
  ssh_password   = "packer"
  ssh_timeout    = "120m"
}
