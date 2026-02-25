#### Notes for SR-iov and GPU passthrough Intel/Nvidia

1) In Server BIOS make sure the following is enabled in the BIOS:

Intel VT-d & VT-x – Intel Compatible list
All AMD CPUs from Bulldozer onwards should be compatible.
SR-iov (for Intel iGPU)

2) Get device IDs:
`lspci -nn`

3) Enable IOMMU in GRUB (check Intel or AMD commands below - choose the right one)
nano /etc/default/grub

# For Nvidia
`GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on iommu=pt"`

# For Nvidia + Intel
`GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on iommu=pt i915.enable_guc=3 i915.max_vfs=7"`

# For AMD
`GRUB_CMDLINE_LINUX_DEFAULT="quiet amd_iommu=on"`

Verify that IOMMU is enabled by running `dmesg | grep -e DMAR -e IOMMU` and looking for a line indicating it is enabled

Save and exit

# Intel SR-iov
```
apt update && apt install pve-headers-$(uname -r)
apt install git sysfsutils dkms build-* unzip -y
```
edit the sources list with `nano /etc/apt/sources.list`

add the following lines:
```
#non-free firmwares
deb http://deb.debian.org/debian bookworm non-free-firmware

#non-free drivers and components
deb http://deb.debian.org/debian bookworm non-free
```
and save the file

```
apt update && apt install intel-media-va-driver-non-free intel-gpu-tools vainfo
```

This next step copies a driver missing on proxmox installs and will remove the -2 error for this file in dmesg.
```
wget -r -nd -e robots=no -A '*.bin' --accept-regex '/plain/' https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915/adlp_dmc.bin

cp adlp_dmc.bin /lib/firmware/i915/
```

## Compile and Install the new driver

### Clone github project ###
```
cd ~
git clone https://github.com/strongtz/i915-sriov-dkms.git

```
### For kernel 6.8:
git checkout 81c0bb4
### modify dkms.conf ###
```
cd i915-sriov-dkms
nano dkms.conf
```
change these two lines as follows:
```
PACKAGE_NAME="i915-sriov-dkms"
PACKAGE_VERSION="6.8"
```
save the file

### Compile and Install the Driver
```
cd ~
mv i915-sriov-dkms/ /usr/src/i915-sriov-dkms-6.8
dkms install --force -m i915-sriov-dkms -v 6.8
```
and use `dkms status` to verify the module is now installed


4) run the command `"update-grub"`

5) Enable VFIO Modules
`nano /etc/modules`
Add the following modules:
```
vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
```
Then, save and exit

6) `update-initramfs -u -k all` and reboot

# Intel
### Find PCIe Bus and update sysfs.conf ###

use `lspci | grep VGA` t find the bus number

you should see something like this:
```
root@pve2:~# lspci | grep VGA
00:02.0 VGA compatible controller: Intel Corporation Raptor Lake-P [Iris Xe Graphics] (rev 04)
```
take the number on the far left and add to the sysfs.conf as follows - note all the proceeding zeros on the bus path are needed
```
echo "devices/pci0000:00/0000:00:02.0/sriov_numvfs = 7" > /etc/sysfs.conf
```
**REBOOT**

Verify the modules are enabled with `dmesg | grep -i vfio` and checking the driver version line is present

7) GPU Isolation From the Host (amend the below to include the IDs of the device you want to isolate)

`echo "options vfio-pci ids=10de:1381,10de:0fbc disable_vga=1" > /etc/modprobe.d/vfio.conf`

8) Blacklist GPU drivers (here are all that you would ever need)
```
echo "blacklist radeon" >> /etc/modprobe.d/blacklist.conf 
echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf 
echo "blacklist nvidia" >> /etc/modprobe.d/blacklist.conf 
echo "blacklist nvidiafb" >> /etc/modprobe.d/blacklist.conf
echo "blacklist nvidia_drm" >> /etc/modprobe.d/blacklist.conf
```

Reboot your machine, be sure to use the web gui because with the gpu passed through you will no longer get video out.
The start up will begin but then appear to hang even though proxmox has started fine.

9) Create a new VM and add the GPU via hardware menu
You may need to set it as primary GPU
You may need to add a ROM BAR


# FOR INTEL SR-IOV, EVERYTIME THE KERNEL IS UPDATED IN PROXMOX YOU SHOULD DO THE FOLLOWING

update the kernel
dkms install -m i915-sriov-dkms -v 6.8 --force
reboot



### Sources:
https://github.com/JamesTurland/JimsGarage/blob/main/GPU_passthrough/readme.md

https://gist.github.com/scyto/e4e3de35ee23fdb4ae5d5a3b85c16ed3#file-proxmox-vgpu-md