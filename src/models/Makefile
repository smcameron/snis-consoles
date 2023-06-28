all: switch.stl

clean:
	/bin/rm -f *.stl

%.stl:	%.scad
	openscad -o $@ $<

%.dxf:	%.scad
	openscad -o $@ $<

