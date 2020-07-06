### Purpose
The purpose of this repository is to build a base Centos 7 ISO to use later in Terraform for my homelab.

### The setup:
This builder uses the vSphere API, and creates virtual machines remotely. It starts from an ISO file and creates new VMs from scratch.

The way this is currently working is that I have ESXi 7.0.0 (Build 15843807) running (without a license). I have uploaded a generic CentOS-7 minimal ISO that is used as a template to build on top of. Because we're using the unlicensed version of vSphere, we cannot create an ISO template natively, so the next best thing is to build this image on vSphere, export it to the machine running packer, and then manually upload the built iso into the vSphere datastore under `DigistroESXiLocal01 > ISO_Templates > centos7 > CentOS7-Digistro-Template`

Currently only have a build for CentOS. Ubuntu coming soon.

### Usage:

```bash
cd centos
packer build packer.json
```

### How it works:
1. Packer will build a VM to spec and will use the kickstart file `ks.cfg` to configure.
2. While configuring, the kickstart file will install packages and will then use the post installation script to install vmware tools so that Packer can continue manipulating the host (via SSH).
3. Packer will shutdown the machine after it's done being made.
4. From there, we can take our exported .ovf template and upload it to vSphere for later use.
5. You can ssh into the built VM by using:
* username: root
* password: password
