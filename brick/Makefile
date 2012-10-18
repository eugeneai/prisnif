.PHONY: all dis view clean autoref

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
	latex dis.tex || true
	latex dis.tex || true

autoref.dvi: autorefbig.tex
	latex autorefbig.tex || true
	latex autorefbig.tex || true
	mv -f autorefbig.dvi autoref.dvi

autoref.pdf: autoref.dvi
	dvips -O-1in,-1in -o autoref.ps autoref.dvi
	epstopdf autoref.ps > autoref.pdf

#dis.tex:

view:	dis.dvi
	evince dis.dvi

pdf:	dis.pdf
	evince dis.pdf

autoref: autoref.pdf
	evince autoref.pdf

clean:
	rm -f dis.{ps,pdf,aux,bib,toc,aux,log,bcf,dvi,out,run.xml,thm}
