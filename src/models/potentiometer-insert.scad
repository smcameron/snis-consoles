/*
  3d printable insert for a control panel
  An array of potentiometers may be mounted to the insert.
  The insert can then be mounted into to the face of the control
  panel.

  The idea is, it's easy to cut a large hole in a piece of 1/4 inch
  plywood into which the insert may be fitted, but is is difficult
  (impossible) to cut the tiny holes needed for each individual fader
  in such plywood, and anyway the plywood is too thick.

  To use this file, set the following variables (in mm) and then
  include this file.

  These are intentionally commented out here.

plate_thickness = 3;
countersink = 0.01;
pot_horizontal_spacing = 25;
pot_vertical_spacing = 30;
pot_cols = 4;
pot_rows = 5;
web_thickness = 3;
web_height = 10;
hole_radius = 3.5;
plate_horizontal_border = 15;
plate_vertical_border = 15;
plate_height = pot_rows * pot_vertical_spacing + 2 * plate_vertical_border;
plate_width =  pot_cols * pot_horizontal_spacing + 2 * plate_horizontal_border;
screw_radius = 0.5 * 3; 
screw_edge_offset = 5;

web_thickness = 4;
web_height = 8;
web_edge_offset = screw_edge_offset + screw_radius;
web_screw_offset = 2 * web_edge_offset;
web_horiz_len = plate_width - 2 * web_screw_offset;
web_vert_len = plate_height - 2 * web_screw_offset;

*/

$fn=30;

module undrilled_plate()
{
	echo(plate_width, " x ", plate_height, " x ", plate_thickness);
	cube(size = [plate_width, plate_height, plate_thickness]);
}

module drill_hole(x, y, r)
{
	translate(v = [x, y, -plate_thickness * 0.05])
		cylinder(r1 = r, r2 = r, h = plate_thickness * 1.1);
}

module plate_pot_holes()
{
	for (row = [0 : 1 : pot_rows - 1]) {
		y = plate_vertical_border + (row + 0.5) * pot_vertical_spacing;
		for (col = [0 : 1 : pot_cols - 1]) {
			x = plate_horizontal_border + (col + 0.5) * pot_horizontal_spacing;
			drill_hole(x, y, hole_radius);
		}
	}
}

module plate_screw_holes()
{
	drill_hole(screw_edge_offset, screw_edge_offset, screw_radius);
	drill_hole(screw_edge_offset, plate_height - screw_edge_offset, screw_radius);
	drill_hole(plate_width - screw_edge_offset, screw_edge_offset, screw_radius);
	drill_hole(plate_width - screw_edge_offset, plate_height - screw_edge_offset, screw_radius);
}

module plate()
{
	difference() {
		undrilled_plate();
		plate_pot_holes();
		plate_screw_holes();
	}
}

module webbing()
{
	/* Vertical webbing */
	translate(v = [web_edge_offset, web_screw_offset, plate_thickness * 0.9])
		cube(size = [web_thickness, web_vert_len, web_height]);
	translate(v = [plate_width - web_edge_offset - web_thickness, web_screw_offset, plate_thickness * 0.9])
		cube(size = [web_thickness, web_vert_len, web_height]);
	translate(v = [web_screw_offset, web_edge_offset, plate_thickness * 0.9])
		cube(size = [web_horiz_len, web_thickness, web_height]);
	translate(v = [web_screw_offset, plate_height - web_edge_offset - web_thickness, plate_thickness * 0.9])
		cube(size = [web_horiz_len, web_thickness, web_height]);
}

module pot_array_plate()
{
	union() {
		plate();
		webbing();
	}
}

pot_array_plate();
