all: switch.stl \
	nav-5x1-toggle-switch-insert.stl \
	nav-impulse-warp-fader-insert.stl \
	nav-zoom-pot-insert.stl

clean:
	/bin/rm -f *.stl

%.stl:	%.scad
	openscad -o $@ $<

%.dxf:	%.scad
	openscad -o $@ $<

