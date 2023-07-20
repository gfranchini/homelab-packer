# Ubuntu 22.04.2 Packer Template

A lot of the information used to create this template was snagged by this [article](https://www.aerialls.eu/posts/ubuntu-server-2204-image-packer-subiquity-for-proxmox/).

A weird quirk with this Packer code is the `boot_command`. I've observed that the command does not fully type out. Because of this, I've set one of the file paths as a variable and then interpolate that value in the boot command. It's the only way I've been able to get this to work. Aside from that, everything else is pretty standard. 

The password 'packer' used in the the `meta-data` file has been unix encrypted as such: `openssl passwd -6 -salt xyz packer`. The cloud config uses this password to SSH into the VM and run the contents in the file to continue setting up the VM template. 

# Steps to build

1. `packer init`
2. create a file `vars.pkrvars.hcl`. Add the required proxmox creds.
3. `packer build -var-file=vars.pkrvars.hcl .`

# Note

In order for the auto-install to work properly, the DHCP server needs to be running on the same network that the template is being deployed on. Otherwise, the auto-install will stay stuck.