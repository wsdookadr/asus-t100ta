## Usage

You can download the image and flash it to the tablet's eMMC [using dd](https://www.gnu.org/software/coreutils/manual/html_node/dd-invocation.html#dd-invocation):
```
zstdcat file.img.zst | dd of=/dev/mmcblk1 bs=2M
```

Images:

- https://archive.org/details/arch-asus-t100ta-0.1-2025-03-24.img

## Hardware

Asus T100TA specs:

- [Wiki page](https://en.wikipedia.org/wiki/Asus_Transformer#ASUS_Transformer_Book_T100TA_(T100TA))
- [Official specs](https://web.archive.org/web/20220813024105/https://www.asus.com/me-en/Commercial-Laptops/ASUS_Transformer_Book_T100TA/specifications/)
- [LW probe Fedora](https://linux-hardware.org/?probe=2c7298ac53)
- [LW probe Fedora](https://linux-hardware.org/?probe=34656c0496)
- [LW probe Arch](https://linux-hardware.org/?probe=22c56d2c5c)
- [LW probe PostmarketOS](https://linux-hardware.org/?probe=a78534950a)

## OS attempts

Fedora 41 had high base memory usage, many unneeded packages, old Phosh versions, missing packages from rpm repositories. Brightness was working, audio working, wifi working, rotation working.

[Bliss-Go](https://netix.dl.sourceforge.net/project/blissos-x86/Official/BlissOS15/Gapps/Go/Bliss-Go-v15.9.2-x86_64-OFFICIAL-gapps-20241012.iso?viasf=1) was fast and smooth but had random reboots.
Problems getting the regular home router wifi connection working. Rotation working well, brightness working, audio working.

[PostmarketOS](https://linux-hardware.org/?probe=a78534950a) [generic img](https://images.postmarketos.org/bpo/v24.12/generic-x86_64/phosh/20250319-0121/20250319-0121-postmarketOS-v24.12-phosh-22.5-generic-x86_64-lts.img.xz) was pretty good but orientation sensor accelerometer wasn't working. Alpine-derived, definitely faster than Arch, at least in terms of app start time and browsing. Probably missing driver. At this time there's no specific support for ASUS T100TA in the [pmaports](https://gitlab.com/postmarketOS/pmaports/-/tree/master/device/testing), so definitely the driver for the accelerometer might be missing or the one for `intel_backlight` (?) (that's the only time when the backlight was not working, when `intel_backlight` is disabled). Work required in pmaports to support specifics.

[Arch](https://linux-hardware.org/?probe=22c56d2c5c) almost everything works but somewhat slow. Up to date, recent versions of packages, secure, large package selection in repos.

The remainder of this readme and this repo will focus on Arch.

## Network

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

Similar for wired networks.

## Install

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

## Running Ansible playbooks

```
ansible-playbook -i inventory 0.yml
ansible-playbook -i inventory 1.yml
ansible-playbook -i inventory 2.yml
ansible-playbook -i inventory 3.yml
ansible-playbook -i inventory 4.yml
ansible-playbook -i inventory 5.yml
```

## Syncing books

```
ansible-playbook -i inventory sync-books.yml
```

## Images

<img align="left" src="img/1.JPEG" width="400" />
<img align="left" src="img/2.JPEG" width="300" />
<img align="left" src="img/3.JPEG" width="300" />
<img align="left" src="img/4.JPEG" width="300" />
<img align="left" src="img/5.JPEG" width="400" />
<img align="left" src="img/6.JPEG" width="300" />
<img align="left" src="img/7.JPEG" width="300" />


