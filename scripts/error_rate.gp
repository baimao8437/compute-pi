reset
set yrange [0:]
set xlabel 'N'
set style fill solid
set title 'error rate'
set term png enhanced font 'Verdana,10'
set output 'error_rate.png'
set logscale x 10
set datafile separator ","
 
plot "result_error_rate.csv" using 1:2 smooth csplines title 'Baseline', \
'' using 1:3 smooth csplines title 'openMP\_2', \
'' using 1:4 smooth csplines title 'openMp\_4', \
'' using 1:5 smooth csplines title 'AVX', \
'' using 1:6 smooth csplines title 'AVX\_unrolling', \
'' using 1:7 smooth csplines title 'Leibniz', \
'' using 1:8 smooth csplines title 'Leibniz\_avx', \
'' using 1:9 smooth csplines title 'Nilakantha', \
'' using 1:10 smooth csplines title 'Nilakantha\_avx'
