#!/bin/bash

FILE="musiktest_noten.tex"

declare -a rand
rand=(	0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17
	18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35
	36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53
)

declare -a notes
notes=(
	"_N" N "^N" 
	"_a" a "^a" 
	"_b" b "^b"
	"_c" c "^c"
	"_d" d "^d" 
	"_e" e "^e"
	"_f" f "^f" 
	"_g" g "^g" 
	"_h" h "^h" 
	"_i" i "^i" 
	"_j" j "^j" 
	"_k" k "^k" 
	"_l" l "^l" 
	"_m" m "^m" 
	"_n" n "^n"
	"_o" o "^o" 
	"_p" p "^p"
	"_q" q "^q"
)

declare -a note_names
note_names=(
	"ges" "g" "gis" 
	"as" "a" "ais" 
	"b" "h" "his" 
	"ces'" "c'" "cis'" 
	"des'" "d'" "dis'" 
	"es'" "e'" "eis'" 
	"fes'" "f'" "fis'" 
	"ges'" "g'" "gis'" 
	"as'" "a'" "ais'" 
	"b'" "h'" "his'" 
	"ces''" "c''" "cis''" 
	"des''" "d''" "dis''"
	"es''" "e''" "eis''" 
	"fes''" "f''" "fis''" 
	"ges''" "g''" "gis''" 
	"as''" "a''" "ais''" 
	"b''" "h''" "his''" 
	"ces'{}''" "c'{}''" "cis'{}''"
)

/bin/cat <<EOM_header >$FILE
\documentclass[enabledeprecatedfontcommands,parskip=half]{scrartcl}
\usepackage{ngerman}
\usepackage[utf8]{inputenc}
\usepackage{musixtex}
\usepackage{geometry}

\pagenumbering{gobble}
\geometry{a4paper,top=30mm}

\begin{document}
EOM_header

for i in 1 2
do

rand=( $(shuf -e "${rand[@]}") )

if [ $i -gt 1 ]; then
/bin/cat <<EOM_spacer >>$FILE
\vspace{55mm}
EOM_spacer
fi

/bin/cat <<EOM_body >>$FILE
\section*{\centerline{T\"one bestimmen und schreiben}}
\sffamily
\noindent\fbox{%
	\parbox{\textwidth}{%
\textbf{Arbeitsauftrag 2:}\\\\
Schreibe in der ersten Zeile die Tonnamen unter die T\"one. Notiere in der zweiten Zeile die T\"one als \underline{Ganzt\"one}.
	}%
}%
\begin{music}
	\instrumentnumber{1}
	\nobarnumbers
	\staffbotmarg=6\Interligne
	\startpiece
		\NOTEs\wh{${notes[${rand[0]}]}}\en
		\bar
		\NOTEs\wh{${notes[${rand[1]}]}}\en
		\bar
		\NOTEs\wh{${notes[${rand[2]}]}}\en
		\bar
		\NOTEs\wh{${notes[${rand[3]}]}}\en
		\bar
		\NOTEs\wh{${notes[${rand[4]}]}}\en
		\bar
		\NOTEs\wh{${notes[${rand[5]}]}}\en
		\bar
		\NOTEs\wh{${notes[${rand[6]}]}}\en
		\bar
		\NOTEs\csong{${note_names[${rand[7]}]}}\en
		\bar
		\NOTEs\csong{${note_names[${rand[8]}]}}\en
		\bar
		\NOTEs\csong{${note_names[${rand[9]}]}}\en
		\bar
		\NOTEs\csong{${note_names[${rand[10]}]}}\en
		\bar
		\NOTEs\csong{${note_names[${rand[11]}]}}\en
		\bar
		\NOTEs\csong{${note_names[${rand[12]}]}}\en
		\bar
		\NOTEs\csong{${note_names[${rand[13]}]}}\en
		\setdoublebar
	\endpiece
\end{music}
EOM_body
done

/bin/cat <<EOM_footer >>$FILE
\end{document}
EOM_footer
