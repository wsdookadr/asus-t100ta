## specs battery monitor

should run the following to get the most cpu-intensive processes, sorted descending by the cuu column.
this command will exclude ps itself from the ranking:
```
[user@tablet custom]$ sh -c 'exec ps --no-headers --sort -cuu -o "uname,ppid,pid,cuu,comm,exe" --pid "$$" -N ' | head -10
user      118799  118953  3.906 WebExtensions   /usr/lib/librewolf/librewolf
user         485  118799  2.031 librewolf       /usr/lib/librewolf/librewolf
root           2      72  1.575 kswapd0         -
root           1     405  0.344 iio-sensor-prox -
user      118799  118891  0.324 Privileged Cont /usr/lib/librewolf/librewolf
user         485     594  0.265 phosh           /usr/lib/phosh/phosh
user           1  111457  0.215 tmux: server    /usr/bin/tmux
user           1     478  0.178 phoc            /usr/bin/phoc
user         485     699  0.090 gsd-power       /usr/lib/gsd-power
root           1     392  0.072 NetworkManager  -
```

should also get all battery metrics. example:
```
[user@tablet custom]$ upower -i /org/freedesktop/UPower/devices/battery_BATC | grep "energy\|time to empty\|time to full\|percentage"
    energy:              23.1075 Wh
    energy-empty:        0 Wh
    energy-full:         27.6188 Wh
    energy-full-design:  30.225 Wh
    energy-rate:         0.915 W
    time to empty:       25.3 hours
    percentage:          83%
```

all these values need to be stored somewhere to build graphs later on.
the intent will be to correlate power consumption with cpu utilization
and be able to show which apps contributed the most.

it would be useful to also record whether the tablet was used or was idling when the measurement was made.


unfortunately upower has a hardcoded retention of 7 days for the history files:

```
[user@tablet tmp]$ git clone https://code.hyprland.org/fdo-mirrors/upower.git
```

```
[user@tablet upower]$ rg UP_HISTORY_DEFAULT_MAX_DATA_AGE
src/up-history.c
39:#define UP_HISTORY_DEFAULT_MAX_DATA_AGE      (7*24*60*60)    /* seconds */
910:    history->priv->max_data_age = UP_HISTORY_DEFAULT_MAX_DATA_AGE;
```

alternative to upower:
```
[user@tablet upower]$ grep "" /sys/class/power_supply/BATC/{status,capacity,capacity_level,charge_now,charge_full_design,current_now,voltage_now}
/sys/class/power_supply/BATC/status:Discharging
/sys/class/power_supply/BATC/capacity:92
/sys/class/power_supply/BATC/capacity_level:Normal
/sys/class/power_supply/BATC/charge_now:6815000
/sys/class/power_supply/BATC/charge_full_design:8060000
/sys/class/power_supply/BATC/current_now:488000
/sys/class/power_supply/BATC/voltage_now:4190000
```

## other notes

Converting 1st column to day,hour,minute.

```
[user@tablet powertop]$ cat /var/lib/upower/history-charge-SR_Real_Battery-30-123456789.dat  | perl -F'\t' -MTime::Piece -ane '$F[0]=Time::Piece->new($F[0])->strftime("%d-%H:%M"); print join("\t",@F);' | tail -10
16-09:49        89.000  discharging
16-10:06        88.000  discharging
16-10:16        87.000  discharging
16-10:30        86.000  discharging
16-10:42        85.000  discharging
16-10:59        84.000  discharging
16-11:09        83.000  discharging
16-11:26        82.000  discharging
16-11:43        81.000  discharging
16-11:57        80.000  discharging
```

Apparently upower only stores a new line when the percent has changed:

```
[user@tablet powertop]$ cat /var/lib/upower/history-charge-SR_Real_Battery-30-123456789.dat  | perl -F'\t' -MTime::Piece -ane 'chomp $F[-1]; $tp=Time::Piece->new($F[0]); $F[0]=$tp->strftime("%d-%H:%M"); push @F,($tp-$last); print join("\t",@F)."\n";  $last=$tp;' | tail -10
16-10:30        86.000  discharging     811
16-10:42        85.000  discharging     722
16-10:59        84.000  discharging     992
16-11:09        83.000  discharging     631
16-11:26        82.000  discharging     1022
16-11:43        81.000  discharging     992
16-11:57        80.000  discharging     842
16-12:05        79.000  discharging     480
16-12:13        78.000  discharging     511
16-12:22        77.000  discharging     511
```

## other solutions

https://github.com/stgloorious/simple-battery-log - has charts, no point in the cronjob since upower already has historical data

https://github.com/fuenfundachtzig/BatteryLog - has charts, cronjob unnecessary

https://github.com/petterreinholdtsen/battery-stats - complex, deps: matplotlib, numpy, gnuplot, Text::CSV, 

https://github.com/lhl/batterylog - tracks suspend power usage, deps: sqlite, python, uses /sysfs/class/power

https://github.com/miahuoe/batstat - deps: sqlite, C. if WAL was activated it would reduce writes. lacks charts. also unnecessarily
reads values on its own when everything is already available in upower history files.

## upower

```
/var/lib/upower/history-time-empty-*
/var/lib/upower/history-time-full-*
/var/lib/upower/history-charge-*
/var/lib/upower/history-rate-*
```

[upower docs](https://upower.freedesktop.org/docs/)

## powertop

https://bbs.archlinux.org/viewtopic.php?id=256093 - disabling drivers and calibrating 

old powertop versions:

* https://web.archive.org/web/20250315234601/https://releases.linaro.org/archive/13.11/openembedded/sources/powertop-2.4.tar.gz
* https://web.archive.org/web/20250315234911/https://releases.linaro.org/archive/13.06/openembedded/sources/powertop-2.3.tar.gz


