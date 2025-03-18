#!/bin/bash
# gnuplot -p -e \
# '
# set term png size 12000,768;
# set output "history-rate.png";
# set xdata time;
# set xtics rotate by 90 right;
# set xtics 600;
# set timefmt "%s";
# set format x "%d-%H:%M";
# plot "history-rate.txt" using 1:2 title "PowerDraw" with linespoints pt 7 ps .3 ;
# '

gnuplot -p -e \
'
set term png size 12000,768;
set output "history-charge.png";
set xdata time;
set xtics rotate by 90 right;
set xtics 600;
set timefmt "%s";
set format x "%d-%H:%M";
plot "history-charge.txt" using 1:2 title "BatteryCharge" with linespoints pt 7 ps .3 ;
'

