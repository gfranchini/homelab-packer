# Installs the plugin when running `packer init config.pkr.hcl`
packer {
  required_plugins {
    proxmox = {
      version = "= 1.1.3"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}