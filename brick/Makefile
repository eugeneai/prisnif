.PHONY: all dis

all: dis

dis: dis.pdf

dis.pdf: dis.ps
	epstopdf dis.ps > dis.pdf

dis.ps: dis.dvi
	dvips -O-1in,-1in -o dis.ps dis.dvi

dis.dvi: dis.tex
	latex dis.tex
	latex dis.tex
