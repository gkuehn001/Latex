all: pdf

rebuild: clean all

clean:
	rm -f *.tex
	rm -f *.mx*
	rm -f *.log
	rm -f *.aux
	rm -f *.pdf

pdf: tex 
	pdflatex mathetest_6_1.tex

tex: create_tex.sh
	bash create_tex.sh

