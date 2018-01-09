.PHONY: all clean preview

all: srs.pdf

srs-section2.ms:
	touch srs-section2.ms

srs-section3.ms: webflow.eps sql-depend.eps
	touch srs-section3.ms

srs.ms: srs.tmac srs-section1.ms srs-section2.ms srs-section3.ms
	touch srs.ms

srs.pdf: srs.ms 
	groff -s -p -ms -m pspic -Tps srs.ms | ps2pdf - srs.pdf

clean:
	rm srs.pdf

preview: srs.pdf
	mupdf-x11 srs.pdf
