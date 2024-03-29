
include <face-plate.scad>

/* This file provides 2 functions meant to be used:

   1. switch_array_holder(rows, cols);
   2. switch_holder_retaining_gasket(rows, cols);

*/


$fn = 50;

clearance = 0.5;
width = 33 + clearance;
height = 23 + clearance;
depth = 10;
outer_width = width + 3;
outer_height = height + 3;
edge_width = 6;

module switch_holder_screw_hole()
{
	translate(v = [0, 0, -1])
		cylinder(r1 = 1.5, r2 = 1.5, h = 10);
}

module switch_holder()
{
	translate(v = [0.5 * outer_width, 0.5 * outer_height, 0.5 * depth])
		difference() {
			cube(size = [outer_width, outer_height, depth], center = true);
			cube(size = [width, height, depth + 5], center = true);
		}
}

module switch_holder_array(r, c)
{
	union() {
		for (i = [0 : 1 : r - 1]) {
			translate(v = [0, (height + 1.5) * i, 0]) {
				for (j = [0 : 1 : c - 1]) {
					translate(v = [(width + 1.5) * j, 0, 0]) {
						switch_holder();
					}
				}
			}
		}
	}
}

module switch_holder_face_plate(r, c)
{
	w = c * (width + 1.5) + 1.5;
	h = r * (height + 1.5) + 1.5;
	thickness = 3;

	difference() {
		face_plate(w + 2 * edge_width, h + 2 * edge_width, 3);
		translate(v = [edge_width, edge_width, -3]) {
			cube(size = [w, h, 10]);
		}
		translate(v = [0.75 * edge_width, 0.75 * edge_width, 0])
			switch_holder_screw_hole();
		translate(v = [w + 1.25 * edge_width, 0.75 * edge_width, 0])
			switch_holder_screw_hole();
		translate(v = [w + 1.25 * edge_width, h + 1.25 * edge_width, 0])
			switch_holder_screw_hole();
		translate(v = [0.75 * edge_width, h + 1.25 * edge_width, 0])
			switch_holder_screw_hole();
	}
}

module switch_array_holder(r, c) {
	union() {
		switch_holder_face_plate(r, c);
		translate(v = [edge_width, edge_width, 0])
			switch_holder_array(r, c);
	}
}

module button_port()
{
	translate(v = [0, 0, -5])
		cube(size = [28.5, 19, 15]);
}

module switch_holder_retaining_gasket(r, c)
{
	w = c * (width + 1.5) + 1.5;
	h = r * (height + 1.5) + 1.5;
	difference() {
		face_plate(w + 2 * edge_width, h + 2 * edge_width, 3);
		translate(v = [edge_width + 4 , edge_width + 4, 0])
		for (i = [0 : 1 : r - 1]) {
			translate(v = [0, (height + 1.5) * i, 0]) {
				for (j = [0 : 1 : c - 1]) {
					translate(v = [(width + 1.5) * j, 0, 0]) {
						button_port();
					}
				}
			}
		}
		translate(v = [0.75 * edge_width, 0.75 * edge_width, 0])
			switch_holder_screw_hole();
		translate(v = [w + 1.25 * edge_width, 0.75 * edge_width, 0])
			switch_holder_screw_hole();
		translate(v = [w + 1.25 * edge_width, h + 1.25 * edge_width, 0])
			switch_holder_screw_hole();
		translate(v = [0.75 * edge_width, h + 1.25 * edge_width, 0])
			switch_holder_screw_hole();
		translate(v = [edge_width - 1, edge_width - 1, 2])
			cube(size = [c * (width + 2) + 2, r * (height + 2) + 2, 20]);
	}
}
/*
switch_array_holder(3, 4);
translate(v = [200, 0, 0])
	switch_holder_retaining_gasket(3, 4);
*/
