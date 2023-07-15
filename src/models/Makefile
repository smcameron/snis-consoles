all: switch.stl \
	nav-5x1-toggle-switch-insert.stl \
	nav-impulse-warp-fader-insert.stl \
	nav-zoom-pot-insert.stl \
	throttle-handle.stl \
	large-switch.stl \
	nav-5x1-large-switch-array-holder.stl \
	nav-2x5-large-switch-array-holder.stl \
	case_siding.dxf \
	lasercut-lenses.dxf

clean:
	/bin/rm -f *.stl

%.stl:	%.scad
	openscad -o $@ $<

%.dxf:	%.scad
	openscad -o $@ $<

throttle-handle.stl:	throttle-handle.scad

nav-5x1-toggle-switch-insert.stl:	nav-5x1-toggle-switch-insert.scad \
	potentiometer-insert.scad
	openscad -o $@ $<

nav-zoom-pot-insert.stl:	nav-zoom-pot-insert.scad potentiometer-insert.scad face-plate.scad
	openscad -o $@ $<

nav-impulse-warp-fader-insert.stl:	nav-impulse-warp-fader-insert.scad \
	fader-insert-60mm-array.scad face-plate.scad
	openscad -o $@ $<

large-switch.stl:	large-switch.scad
	openscad -o $@ $<

nav-5x4-large-switch-array-holder.stl:	nav-5x4-large-switch-array-holder.scad \
	large-switch-array-holder.scad face-plate.scad
	openscad -o $@ $<

nav-5x1-large-switch-array-holder.stl:	nav-5x1-large-switch-array-holder.scad \
	large-switch-array-holder.scad face-plate.scad
	openscad -o $@ $<

nav-2x5-large-switch-array-holder.stl:	nav-2x5-large-switch-array-holder.scad \
	large-switch-array-holder.scad face-plate.scad
	openscad -o $@ $<

case_siding.dxf:	case_siding.scad
	openscad -o $@ $<

lasercut-lenses.dxf:	lasercut-lenses.scad
	openscad -o $@ $<


