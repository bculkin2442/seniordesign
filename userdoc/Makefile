.PHONY: all clean preview

all: userdoc.pdf

userdoc.ms: userdoc.tmac userdoc-section1.ms
	touch userdoc.ms

userdoc.pdf: userdoc.ms 
	groff -s -p -ms -m pspic -Tps userdoc.ms | ps2pdf - userdoc.pdf

clean:
	rm userdoc.pdf

preview: userdoc.pdf
	mupdf-gl userdoc.pdf
