# Format i nom de la imatge
set term png enhanced
set output "P7-1920-fig5.png"

# Permet escriure lletres gregues i altres mogudes
set encoding utf8

# Mostra els eixos
#set xzeroaxis
#set yzeroaxis

# Títol del gràfic
set title "{/Symbol w}({/Symbol q}) Euler millorat (trajectòries a l'espai de configuració)"

# Rang dels eixos
set xrange[-5.0:60.0]
#set yrange[-3.5:2.50]

# Títols dels eixos
set xlabel "Angle, {/Symbol q}(rad)"
set ylabel "Velocitat angular, {/Symbol w}(rad/s)"

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
set key bottom right

# Plot 
plot "P7-1920-res.dat" index 8 using 2:3 with points t "{/Symbol w}(0)=2sqrt(g/l)+0.03", \
"P7-1920-res.dat" index 9 using 2:3 with points t "{/Symbol w}(0)=2sqrt(g/l)-0.03"
#pause -1
