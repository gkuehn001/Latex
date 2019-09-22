#!/bin/bash

FILE="mathetest_6_1.tex"

declare -a rand
rand=(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17)

declare -a nodelabel
nodelabel=("A" "B" "C" "D" "E")

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
\section{Finde und unterstreiche die Primzahlen}
$num_str
EOM_find_primes
echo find_primes written to $FILE
}

function zahlenstrahl {
/bin/cat <<EOM_zahlenstrahl >>$FILE
\section{Benenne die markierten Punkte auf dem Zahlenstrahl}
\begin{tikzpicture} 
\draw[step=0.5,gray,very thin] (-6,-1) grid (8,1);
\draw[->,very thick] (-5.5,0) -- (7.5,0);
\node[label=below:\$A$] (A) at (-5,0) {};
\fill (A) circle (2pt);
\node[label=below:\$B$] (B) at (7,0) {};
\fill (B) circle (2pt);
EOM_zahlenstrahl
declare -a znumbers;
echo "\end{tikzpicture}" >> $FILE
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
find_primes
zahlenstrahl
footer
