#!/bin/bash
export DISPLAY=:0
gsettings set org.gnome.settings-daemon.peripherals.touchscreen orientation-lock false
gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled true
gsettings set org.gnome.software download-updates false
gsettings set org.gnome.software allow-updates false
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled false

gsettings set org.gnome.desktop.session idle-delay 300
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
gsettings set sm.puri.phoc auto-maximize true

# pressing the power button does what
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power power-saver-profile-on-low-battery true
# when plugged in, when it goes to sleep and how
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 900
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'suspend'
# when on battery, when it goes to sleep and how
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 900
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend'

sudo brightnessctl s 15%
sudo iw wlan0 set power_save off
