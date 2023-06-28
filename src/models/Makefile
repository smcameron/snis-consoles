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

nav-5x1-toggle-switch-insert.stl:	nav-5x1-toggle-switch-insert.scad \
	potentiometer-insert.scad
	openscad -o $@ $<

nav-zoom-pot-insert.stl:	nav-zoom-pot-insert.scad potentiometer-insert.scad
	openscad -o $@ $<

nav-impulse-warp-fader-insert.stl:	nav-impulse-warp-fader-insert.scad \
	fader-insert-60mm-array.scad
	openscad -o $@ $<

