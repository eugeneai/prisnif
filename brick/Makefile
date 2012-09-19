.PHONY: all dis view

PICS=pics/AnBase.eps pics/Chunk2.eps pics/Chunk.eps pics/logics_schema_1.eps \
	pics/Parallel.eps pics/PST2.eps pics/PST.eps
TEXS=appendix.tex bibliography.tex chapter1.tex chapter2.tex \
	chapter3.tex chapter4.tex conclusions.tex dis.tex


all: dis

dis: dis.pdf

dis.pdf: dis.ps
	epstopdf dis.ps > dis.pdf

dis.ps: dis.dvi $(PICS)
	dvips -O-1in,-1in -o dis.ps dis.dvi

dis.dvi: $(TEXS)
	latex dis.tex
	latex dis.tex

dis.tex:

view:	dis.dvi
	evince dis.dvi

pdf:	dis.pdf
	evince dis.pdf

