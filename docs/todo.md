## enhance security with some form of sandboxing

[landrun](https://github.com/Zouuup/landrun)

## explore speedups

* [this gist](https://gist.github.com/jwbee/7e8b27e298de8bbbf8abfa4c232db097) discusses speeding up certain packages by using a better allocator and better compiler
* replacing some [core tools](https://lwn.net/SubscriberLink/1014002/580b8750bf02cf41/) via oxidizr could help

## fix koreader settings pre-provisioned

koreader settings are pre-provisioned but this ends up in koreader crashing.
koreader should instead be allowed to generate and initialize its stuff on its own and then
the settings file should should be applied.

## [done] quick info shortcut

have a desktop shortcut that shows

* the ip in the local network
* the eMMC health
* the battery details

## file sharing server

have a desktop shortcut that sets up a password-based temporary SFTP server for uploading files
to the tablet.

## automate OSK

In gnome-control-center `Settings > Accessibility > Typing > Screen Keyboard`

Need a way to check that checkbox programmatically.

This does not actually work:
```
gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled true
```

## automate tv station update

There should be a way to automatically test all streams and see which actually works
on this tablet or with hardware similar to the one on the tablet.

```
curl -s https://iptv-org.github.io/iptv/countries/ro.m3u
curl -s https://iptv-org.github.io/iptv/countries/us.m3u
```

maybe this as well
```
https://github.com/eklins/FDTV
```

## [solved] pdf viewer needs to save state

solution: switched from evince to papers (papers does save state)

evince can't remember the page number

https://gitlab.gnome.org/GNOME/evince/-/issues/1642

looks like the page number lives in some external data store

https://gitlab.gnome.org/GNOME/evince/-/issues/1936#note_1736476

none of the existing settings is explicitly for remembering the page `gsettings list-recursively | grep Evince`.


