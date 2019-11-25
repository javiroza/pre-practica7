# Format i nom de la imatge
set term png enhanced
set output "P7-1920-fig6.png"

# Permet escriure lletres gregues i altres mogudes
set encoding utf8

# Mostra els eixos
#set xzeroaxis
#set yzeroaxis

# Títol del gràfic
set title "Convergència d'Euler millorat a través de l'evolució de l'Energia total"

# Rang dels eixos
#set xrange[-5.0:60.0]
set yrange[1.4:2.60]

# Títols dels eixos
set xlabel "Temps, t (s)"
set ylabel "Energia total E, (J)"

# Canvia els nombres dels eixos per nombres personalitzats
#set ytics("1x10^-^1^0" 1.00e-10,"1x10^-^0^5" 1.00e-05,"1x10^0" 1.00e+00,"1x10^5" 1.00e+05,"1x10^1^0" 1.00e+10)
#set xtics("1x10^-^3" 1.00e-03,"1x10^-^2" 1.00e-02,"1x10^-^1" 1.00e-01,"1x10^0" 1.00e+00,"1x10^1" 1.00e+01)

# Format dels nombres dels eixos
set format y '%.2f'
set format x '%.2f'

# Escala dels eixos logarítmica
#set logscale y
#set logscale x

# Posició de la llegenda
set key top left

# Plot 
plot "P7-1920-res.dat" index 10 using 1:6 with points t "N=600", \
"P7-1920-res.dat" index 11 using 1:6 with points t "N=1300", \
"P7-1920-res.dat" index 12 using 1:6 with points t "N=2600", \
"P7-1920-res.dat" index 13 using 1:6 with points t "N=15000"
#pause -1
