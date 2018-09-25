
set terminal png
set output 'abw.png'

set size square
unset key
set xlabel "time [s]"
set ylabel "Available bandwidth"


set xzeroaxis linetype 3 linewidth 2.5 lc 0

plot "abw.tr" w l lt 1 lc rgbcolor "#000000",\
        "extraction_abw.txt" with lp lt 1 pt 7 ps 0.5 lc rgbcolor "#0000FF"

set terminal x11
set output
