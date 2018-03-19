.PHONY: all clean preview

all: designdoc.pdf

designdoc-section2.ms:
	touch designdoc-section2.ms

designdoc-section3.ms: login-diagram.eps clockinout-diagram.eps
	touch designdoc-section3.ms

designdoc.ms: designdoc.tmac designdoc-section1.ms designdoc-section2.ms designdoc-section3.ms
	touch designdoc.ms

designdoc.pdf: designdoc.ms 
	groff -s -p -ms -m pspic -Tps designdoc.ms | ps2pdf - designdoc.pdf

clean:
	rm designdoc.pdf

preview: designdoc.pdf
	mupdf-gl designdoc.pdf
