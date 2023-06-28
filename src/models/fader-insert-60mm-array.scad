/*
  3d printable insert for a control panel
  An array of 60mm faders may be mounted to the insert.
  The insert can then be mounted into to the face of the control
  panel.

  The idea is, it's easy to cut a large hole in a piece of 1/4 inch
  plywood into which the insert may be fitted, but is is difficult
  (impossible) to cut the tiny holes needed for each individual fader
  in such plywood, and anyway the plywood is too thick.

Define the following variables, then include this file and call

	fader_60mm_array_insert(0, 0, fader_spacing, fader_count);

plate_thickness = 3;
countersink = 0.01;
fader_spacing = 18;
fader_count = 10;
web_thickness = 3;
web_height = 10;
tang_hole_width = 2;
plate_height = 110;

*/

$fn=30;

module fader_screw_hole(x, y, screw_radius, head_radius, hole_depth, countersink_depth)
{
	offset = countersink_depth * 0.5;
	rotate(v = [1, 0, 0], a = 180) {
		translate(v = [x, y, -offset]) {
			union() {
				cylinder(h = hole_depth + offset, r1 = screw_radius, r2 = screw_radius);
				cylinder(h = countersink_depth + offset, r1 = head_radius, r2 = head_radius);
			}
		}
	}
}

module fader_tang_hole(width, length, depth)
{
	translate(v = [0, 0, -0.4 * depth])
		cube(size = [width, length, depth], center = true);
}

module fader_60mm_holes(x, y)
{
	translate(v = [0, 0, plate_thickness]) {
		fader_screw_hole(x, y + 39.5, 0.5 * 3, 0.5 * 5, plate_thickness + 2, countersink);
		fader_screw_hole(x, y - 39.5, 0.5 * 3, 0.5 * 5, plate_thickness + 2, countersink);
	}
	translate(v = [0, 0, plate_thickness + 1]) {
		translate(v = [x, y, 0])
			fader_tang_hole(tang_hole_width, 71, plate_thickness + 2);
	}
}


module fader_60mm_hole_array(x, y, spacing, count)
{
	for (i = [0 : 1 : count - 1]) {
		fader_60mm_holes(x + i * spacing, y);
	}
}

module fader_60mm_array_insert(x, y, spacing, count)
{
	translate(v = [0, 0, plate_thickness]) 
	rotate(v = [1, 0, 0], a = 180)
	union() {
		difference() {
			translate(v = [x, y - plate_height / 2, 0])
				cube(size = [(count + 1) * spacing, plate_height, plate_thickness]);
			fader_60mm_hole_array(x + spacing, y, spacing, count);
			translate(v = [0, 0, plate_thickness]) {
				fader_screw_hole(4, -plate_height / 2 + 4, 0.5 * 3, 0.5 * 5, plate_thickness + 2, countersink);
				fader_screw_hole(4, plate_height / 2 - 4, 0.5 * 3, 0.5 * 5, plate_thickness + 2, countersink);
				fader_screw_hole((count + 1) * spacing - 4, -plate_height / 2 + 4, 0.5 * 3, 0.5 * 5, plate_thickness + 2, countersink);
				fader_screw_hole((count + 1) * spacing - 4, plate_height / 2 - 4, 0.5 * 3, 0.5 * 5, plate_thickness + 2, countersink);
			}
		}
		translate(v = [0.5 * spacing * (count + 1), plate_height / 2 - 4, -plate_thickness]) 
			cube(size = [spacing * count, web_thickness, web_height], center = true);
		translate(v = [0.5 * spacing * (count + 1), -plate_height / 2 + 4, -plate_thickness]) 
			cube(size = [spacing * count, web_thickness, web_height], center = true);
		translate(v = [5, 0, -plate_thickness]) 
			cube(size = [web_thickness, 0.8 * plate_height, web_height], center = true);
		translate(v = [(count + 1) * spacing - 5, 0, -plate_thickness]) 
			cube(size = [web_thickness, 0.8 * plate_height, web_height], center = true);
	}
}

fader_60mm_array_insert(0, 0, fader_spacing, fader_count);


