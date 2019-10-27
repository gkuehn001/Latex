all: pdf

test2: pdf2

rebuild: clean all

clean:
	rm -f *.tex
	rm -f *.mx*
	rm -f *.log
	rm -f *.aux

pdf: tex musiktest_noten.mx1
	pdflatex musiktest_noten.tex

tex: create_tex.sh
	bash create_tex.sh

pdf2: tex2 musiktest_noten.mx1
	pdflatex musiktest_noten.tex

tex2: create_tex_2.sh
	bash create_tex_2.sh

musiktest_noten.mx1: 
	pdflatex musiktest_noten.tex
	musixflx musiktest_noten
