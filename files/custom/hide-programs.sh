#!/bin/bash
readarray -t PROGRAMS <<EOF
/usr/share/applications/bvnc.desktop
/usr/share/applications/bssh.desktop
/usr/share/applications/avahi-discover.desktop
/usr/share/applications/vim.desktop
/usr/share/applications/btop.desktop
/usr/share/applications/mpv.desktop
/usr/share/applications/htop.desktop
/usr/share/applications/qv4l2.desktop
/usr/share/applications/qvidcap.desktop
/usr/share/applications/gtk-lshw.desktop
/usr/share/applications/vlc.desktop
/usr/share/applications/libreoffice-base.desktop
/usr/share/applications/libreoffice-calc.desktop
/usr/share/applications/libreoffice-draw.desktop
/usr/share/applications/libreoffice-impress.desktop
/usr/share/applications/libreoffice-math.desktop
/usr/share/applications/libreoffice-startcenter.desktop
/usr/share/applications/libreoffice-writer.desktop
/usr/share/applications/libreoffice-xsltfilter.desktop
/usr/share/applications/org.gnome.Extensions.desktop
/usr/share/applications/org.gnome.Evince.desktop
/usr/share/applications/org.gnome.Papers.desktop
/usr/share/applications/djvulibre-djview4.desktop
/usr/share/applications/smplayer.desktop
EOF

for x in "${PROGRAMS[@]}"; do
  if grep "NoDisplay" $x; then
    if grep "NoDisplay=false" $x; then
      perl -p -i -e 's{NoDisplay=false}{NoDisplay=true}' $x
    fi
  else
    perl -p -i -e 's{(\[Desktop Entry\])}{$1\nNoDisplay=true\n}' $x
  fi
done
