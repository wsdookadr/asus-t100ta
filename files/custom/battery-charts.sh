#!/bin/bash
rm -rf /home/user/battery_report/
mkdir /home/user/battery_report/

cp $(find /var/lib/upower/history-charge*SR_Real_Battery*)      /home/user/battery_report/battery-history-charge.txt
cp $(find /var/lib/upower/history-rate*SR_Real_Battery*)        /home/user/battery_report/battery-history-rate.txt
cp $(find /var/lib/upower/history-time-empty*SR_Real_Battery*)  /home/user/battery_report/battery-time-empty.txt

gnuplot -p -e \
'
set term png size 12000,768;
set output "/home/user/battery_report/battery-history-charge.png";
set xdata time;
set xtics rotate by 90 right;
set xtics 15*60;
set timefmt "%s";
set format x "%d-%H:%M";
plot "/home/user/battery_report/battery-history-charge.txt" using 1:2 title "Charge(%)" with linespoints pt 7 ps .3 ;
'

gnuplot -p -e \
'
set term png size 12000,768;
set output "/home/user/battery_report/battery-history-rate.png";
set xdata time;
set xtics rotate by 90 right;
set xtics 15*60;
set timefmt "%s";
set format x "%d-%H:%M";
plot "/home/user/battery_report/battery-history-rate.txt" using 1:2 title "PowerDraw(W)" with linespoints pt 7 ps .3 ;
'

gnuplot -p -e \
'
set term png size 12000,768;
set output "/home/user/battery_report/battery-time-empty.png";
set xdata time;
set xtics rotate by 90 right;
set xtics 15*60;

set yrange [0:0 < * < 17 * 3600];
set timefmt "%s";
set format x "%d-%H:%M";
plot "/home/user/battery_report/battery-time-empty.txt" using 1:2 title "TimeEmpty(s)" with linespoints pt 7 ps .3 ;
'

cd /home/user/
zip -r battery_report.zip battery_report/
