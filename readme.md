## Hardware

Asus T100TA specs:

- [Wiki page](https://en.wikipedia.org/wiki/Asus_Transformer#ASUS_Transformer_Book_T100TA_(T100TA))
- [Official specs](https://web.archive.org/web/20220813024105/https://www.asus.com/me-en/Commercial-Laptops/ASUS_Transformer_Book_T100TA/specifications/)
- [LW probe Fedora](https://linux-hardware.org/?probe=2c7298ac53)
- [LW probe Fedora](https://linux-hardware.org/?probe=34656c0496)
- [LW probe Arch](https://linux-hardware.org/?probe=22c56d2c5c)
- [LW probe PostmarketOS](https://linux-hardware.org/?probe=a78534950a)

## OS attempts

Fedora 41 - high base memory usage, many unneeded packages, old Phosh versions, missing packages from rpm repositories, brightness working, audio working, wifi working, rotation working.

[Bliss-Go](https://netix.dl.sourceforge.net/project/blissos-x86/Official/BlissOS15/Gapps/Go/Bliss-Go-v15.9.2-x86_64-OFFICIAL-gapps-20241012.iso?viasf=1) - fast, smooth, random resets(reasons unknown), couldn't get wifi to work with home router, rotation working well, brightness working, audio working.

[PostmarketOS](https://linux-hardware.org/?probe=a78534950a) - [generic img](https://images.postmarketos.org/bpo/v24.12/generic-x86_64/phosh/20250319-0121/20250319-0121-postmarketOS-v24.12-phosh-22.5-generic-x86_64-lts.img.xz) was pretty good but orientation sensor accelerometer wasn't working. apps and browser were fast. probably missing driver. At this time there's no specific support for ASUS T100TA in the [pmaports](https://gitlab.com/postmarketOS/pmaports/-/tree/master/device/testing), so definitely the driver for accelerometer might be missing or the one for `intel_backlight` (?) (that's the only time when the backlight was not working, when `intel_backlight` is disabled). work required in pmaports to support specifics.

Arch - everything works(except for the camera which doesn't work anywhere). up to date, recent versions of packages, large package selection in repos.

The remainder of this readme is about Arch.

## Using the pre-built image

Download the image and flash it to the tablet's eMMC:
```
wget -O arch.img.zst --continue https://archive.org/download/arch-asus-t100ta-0.1-2025-03-24.img/arch-asus-t100ta-0.1-2025-03-24.img.zst
zstdcat arch.img.zst | dd of=/dev/mmcblk1 bs=2M
```

Credentials:
```
user: user
pass: 1234
```

## Building the image

### Network

If the Arch iso doesn't provide network connectivity out of the box, you can connect manually.

```
iwctl --passphrase <pass> station wlan0 connect-hidden <home_network_name>
```

[source](https://unix.stackexchange.com/a/664671/484783)

```
ip addr flush dev wlan0
ip link set wlan0 up
ip route add 192.168.1.1 dev wlan0
ip addr add 192.168.1.178/32 dev wlan0
ip route add default via 192.168.1.1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
```

### Install

Boot from [Arch 2025-03-01](https://archive.archlinux.org/iso/2025.03.01/archlinux-2025.03.01-x86_64.iso).

```
archinstall
```

After the installer drops into chroot:
```
pacman -S networkmanager rsync python openssh dhclient
```

Reboot. Login as root:
```
systemctl enable NetworkManager
systemctl start NetworkManager
systemctl enable sshd
systemctl start sshd
```

Set up sudo:
```
user@perm1:~/t100ta/arch$ ssh-copy-id -i ~/.ssh/t100ta-key user@192.168.1.113
[..]
Number of key(s) added: 1
[..]

user@perm1:~/t100ta/arch$ ssh -i ~/.ssh/t100ta-key user@192.168.1.113
Last login: Sun Mar 23 22:33:08 2025 from 192.168.1.150

[user@tablet ~]$ su
Password:
[root@tablet user]# echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
```

### Running Ansible playbooks

Run all playbooks numbered 0 up to 5, the rest are optional.

```
ansible-playbook -i inventory 0.yml
```

## Syncing books

```
ansible-playbook -i inventory sync-books.yml
```

## Images

<img align="left" src="img/1.JPEG" width="400" />
<img align="left" src="img/4.JPEG" width="300" />


