.PHONY: all clean preview

%.pic: %.gv
	dot -Tpic $< > $@

%.ps: %.gv
	dot -Tps $< > $@

all: srs.pdf

srs-section2.ms: usermodes.pic
	touch srs-section2.ms

srs-section3.ms: kiosklogin.ps userlogin.ps genericui.ps erdiagram.eps forum.ps
	touch srs-section3.ms

srs.ms: srs.tmac srs-section1.ms srs-section2.ms srs-section3.ms
	touch srs.ms

srs.pdf: srs.ms 
	groff -s -p -ms -m pspic -Tps srs.ms | ps2pdf - srs.pdf

clean:
	rm srs.pdf

preview: srs.pdf
	mupdf-gl srs.pdf
