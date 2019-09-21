#!/bin/bash

FILE="musiktest_noten.tex"

declare -a rand
rand=(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17)

declare -a notes
notes=(N a b c d e f g h i j k l m n o p q)

declare -a note_names
note_names=("g" "a" "h" "c'" "d'" "e'" "f'" "g'" "a'" "h'" "c''" "d''" "e''" "f''" "g''" "a''" "h''" "c'{}''")

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
\textbf{Arbeitsauftrag:}\\\\
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
