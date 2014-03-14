set xdata time
set timefmt "%s"
set format x "%d"
set key right bottom
set y2label "Stems"
set ylabel "Coverage (%)"
set xlabel "Day"
set y2range [0:5000]
set yrange [0:100]
set y2tics border
set ytics border
plot "./kumyk-yoldash-coverage.dat" using ($1-86400):2 title "Coverage" ls 19, "./kumyk-yoldash-coverage.dat" using ($1-86400):4 axes x1y2 title "Stems" ls 12

##set terminal postscript font "Helvetica" 20
##set output "./kumyk-yoldash-coverage.ps"
##plot "./kumyk-yoldash-coverage.dat" using 1:2 title "Coverage" ls 19, "./kumyk-yoldash-coverage.dat" using 1:4 axes x1y2 title "Stems" ls 12
