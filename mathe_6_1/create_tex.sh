#!/bin/bash

FILE="mathetest_6_1.tex"

declare -a rand
rand=(1 2 3 4 5 6 7 8 9 10 11)

declare -a nodelabel
nodelabel=("A" "B" "C" "D" "E" "F" "G")

declare -a primes
primes=(2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97)

declare -a non_primes

for i in {1..100}
do
	found=0
	for prime in "${primes[@]}"
	do
    		if [ "$prime" -eq "$i" ] ; then
        	found=1
   		fi
	done
	if [ "$found" -eq "0" ] ; then
		non_primes[$i]=$i
	fi
done


function header {
/bin/cat <<EOM_header >$FILE
\documentclass[enabledeprecatedfontcommands,parskip=half]{scrartcl}
\usepackage{ngerman}
\usepackage[utf8]{inputenc}
\usepackage{geometry}
\usepackage{pgfplots}
\usepackage{tikz}
\usetikzlibrary{arrows.meta}

\pagenumbering{gobble}
\geometry{a4paper,top=30mm}

\begin{document}
\section*{\centerline{Mathe\"ubungen 1}}
EOM_header
echo header written to $FILE!
}

function find_primes {
num_primes=$((5 + RANDOM % 4))
echo $num_primes
declare -a numbers
primes=( $(shuf -e "${primes[@]}") )
non_primes=( $(shuf -e "${non_primes[@]}") )
for i in {0..10}
do
	if [ "$num_primes" -ge "$i" ]
	then
		numbers[$i]=${primes[$i]}
	else
		numbers[$i]=${non_primes[$i]}
	fi
done
numbers=( $(shuf -e "${numbers[@]}") )
num_str=$(printf ", %s" "${numbers[@]}")
num_str=${num_str:2}
/bin/cat <<EOM_find_primes >>$FILE
$num_str
EOM_find_primes
echo "\\\\" >> $FILE
echo "\\\\" >> $FILE
echo find_primes written to $FILE
}

function zahlenstrahl {
/bin/cat <<EOM_zahlenstrahl >>$FILE
\begin{tikzpicture} 
\draw[step=0.5,gray,very thin] (-6,-1) grid (8,1);
\draw[->,very thick] (-5.5,0) -- (7.5,0);
EOM_zahlenstrahl
declare -a znumbers;
rand=( $(shuf -e "${rand[@]}") )
for i in {0..4}
do
	znumbers[$i]=${rand[$i]}
done
znumbers["5"]="0"
znumbers["6"]="12"
znumbers=($(printf '%i\n' "${znumbers[@]}"|sort -k1,1n))
declare -a shownumbers
shownumbers=(0 1 2 3 4 5)
shownumbers=( $(shuf -e "${shownumbers[@]}") )
declare -a multiplier
multiplier=(1 10 100)
multiplier=( $(shuf -e "${multiplier[@]}") )
startpoint=0
endpoint=0
while [ "$startpoint" -gt "-1" ] || [ "$endpoint" -lt "1" ]
do
	startpoint=$(( (RANDOM % 160 - 80) * $multiplier))
	endpoint=$(( $startpoint + $multiplier * 12 ))
done
for i in {0..6}
do
	label=${nodelabel[$i]}
	if [ "$i" -eq "${shownumbers[0]}" ] || [ "$i" -eq "${shownumbers[1]}"  ]
	then
		label="$(($startpoint + ${znumbers[$i]} * $multiplier ))"
	fi
	echo "\node[label=below:\$${label}$] (${nodelabel[$i]}) at ($(( ${znumbers[$i]} - 5 )),0) {};" >> $FILE
	echo "\fill (${nodelabel[$i]}) circle (2pt);" >> $FILE
done
echo "\end{tikzpicture}" >> $FILE
echo "\\\\" >> $FILE
echo "\\\\" >> $FILE
echo "\\\\" >> $FILE
echo "\\\\" >> $FILE
#echo "\\\\znumber ${znumbers[@]}" >> $FILE
#echo "\\\\shownumbers ${shownumbers[@]}" >> $FILE
#echo "\\\\$startpoint" >> $FILE
}

function coordinate_system {
rand=( $(shuf -e "${rand[@]}") )

#/bin/cat <<EOM_spacer >>$FILE
#\vspace{55mm}
#EOM_spacer

/bin/cat <<EOM_body >>$FILE
\sffamily
\\
\begin{tikzpicture}
\begin{axis}[
axis lines=middle,
axis line style={Stealth-Stealth, very thick},
xmin=-3.5, xmax=3.5, ymin=-3.5, ymax=3.5,
xtick distance=1,
ytick distance=1,
xlabel=\$x$,
ylabel=\$y$,
title={Koordinatensystem},
grid=major,
grid style={thin, densely dotted, black!20}]
\node[] at (axis cs: 3,3) {\$I$};
\node[] at (axis cs: -3,3) {\$II$};
\node[] at (axis cs: -3,-3) {\$III$};
\node[] at (axis cs: 3,-3) {\$IV$};
\end{axis}
\end{tikzpicture}
Weiterer Text\\\\
noch eine Zeile
EOM_body
echo coordinate_system written to $FILE
}

function footer {
/bin/cat <<EOM_footer >>$FILE
\end{document}
EOM_footer
echo footer written to $FILE
}

header
echo "\section{Finde und unterstreiche die Primzahlen}" >> $FILE
find_primes
find_primes

echo "\section{Benenne die markierten Punkte auf dem Zahlenstrahl}" >> $FILE
zahlenstrahl
zahlenstrahl
zahlenstrahl
zahlenstrahl
zahlenstrahl
footer
