## Status

Still trying to understand if rtcwake will work on this tablet.
Kernel parameters need to be enabled.

## Analysis

RTC settings:
```
[root@tablet user]# cat /proc/driver/rtc
rtc_time        : 01:00:57
rtc_date        : 2025-03-17
24hr            : yes
periodic_IRQ    : no
update_IRQ      : no
HPET_emulated   : no
BCD             : yes
DST_enable      : no
periodic_freq   : 1024
batt_status     : okay
```


Tablet can't suspend and use rtcwake:
```
[root@tablet user]# sudo /usr/bin/rtcwake -m mem -t $(date +%s -d '+ 2 minutes')
rtcwake: assuming RTC uses UTC ...
rtcwake: set rtc wake alarm failed: Invalid argument
```

Tablet doesn't have the right wakealarm file in place

```
[user@tablet ~]$ cat /sys/class/rtc/rtc0/wakealarm
cat: /sys/class/rtc/rtc0/wakealarm: No such file or directory
```

The kernel parameter `rtc_cmos.use_acpi_alarm` is disabled:
```
[root@tablet user]# cat /sys/module/rtc_cmos/parameters/use_acpi_alarm
N
```

Get current kernel parameters:
```
[root@tablet user]# cat /proc/cmdline
initrd=\initramfs-linux.img root=PARTUUID=4ae7c187-b76a-43c5-8324-c826b5d4f8b2 zswap.enabled=0 rw rootfstype=ext4
```

Arch Linux uses `systemd-boot` as a bootloader.
To add parameters use `/boot/loader/entries/arch.conf` or press `e` at boot time so you can add params.

I have actually tried that kernel parameter but it did not work.

## Conclusion

Tablet has an RTC(real-time clock) but it does not have an alarm.

## References

https://bbs.archlinux.org/viewtopic.php?id=284075
