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

## pdf viewer needs to save state

evince can't remember the page number

https://gitlab.gnome.org/GNOME/evince/-/issues/1642

looks like the page number lives in some external data store

https://gitlab.gnome.org/GNOME/evince/-/issues/1936#note_1736476

none of the existing settings is explicitly for remembering the page `gsettings list-recursively | grep Evince`.


