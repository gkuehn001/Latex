#!/bin/bash

FILE="mathetest_6_1.tex"

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
\usepackage{geometry}
\usepackage{pgfplots}
\usetikzlibrary{arrows.meta}

\pagenumbering{gobble}
\geometry{a4paper,top=30mm}

\begin{document}
EOM_header


rand=( $(shuf -e "${rand[@]}") )

#/bin/cat <<EOM_spacer >>$FILE
#\vspace{55mm}
#EOM_spacer

/bin/cat <<EOM_body >>$FILE
\section*{\centerline{Negative Zahlen}}
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


/bin/cat <<EOM_footer >>$FILE
\end{document}
EOM_footer
