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
fader_screw_holes = 1;
use_fader_snap_arms = 1;
fader_phys_length = 88;
fader_phys_width = 12;
fader_snap_arm_count = 4;
side_margin = 15;

*/

plate_width = (fader_count - 1) * fader_spacing + 2 * side_margin;

include <face-plate.scad>
include <cantilever-snap.scad>

module fader_snap_arm()
{
	snap_arm(11);
}

module panel_snap_arm()
{
	scale(v = [1.0, 0.6, 0.5])
		snap_arm(2.0 * 6.6);
}

module fader_snap_arms(fader_phys_length, fader_phys_width, count)
{
	fader_snap_arm();
	translate(v = [fader_phys_length, 0, 0])
			rotate(v = [0, 0, 1], a = 180)
				fader_snap_arm();

	for (i = [1 : 1 : count]) {
		translate(v = [i * fader_phys_length/(count + 1), -0.5 * fader_phys_width, 0])
			rotate(v = [0, 0, 1], 90)
				fader_snap_arm();
		translate(v = [i * fader_phys_length/(count + 1), 0.5 * fader_phys_width, 0])
			rotate(v = [0, 0, 1], -90)
				fader_snap_arm();
	}
}

module panel_snap_arms()
{
	translate(v = [plate_thickness + 0.95 * plate_width, -0.5 * plate_height, 0])
	for (i = [0 : 1 : 3]) {
		translate(v = [0, (i + 1) * 0.20 * plate_height, 0])
			panel_snap_arm();
	}
	translate(v = [-plate_thickness + 0.05 * plate_width, 0.5 * plate_height, 0])
	rotate(v = [0, 0, 1], a = 180)
	for (i = [0 : 1 : 3]) {
		translate(v = [0, (i + 1) * 0.20 * plate_height, 0])
			panel_snap_arm();
	}
}

$fn=100;

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
	if (fader_screw_holes > 0)  {
		translate(v = [0, 0, plate_thickness]) {
			fader_screw_hole(x, y + 39.5, 0.5 * 3, 0.5 * 5, plate_thickness + 2, countersink);
			fader_screw_hole(x, y - 39.5, 0.5 * 3, 0.5 * 5, plate_thickness + 2, countersink);
		}
	}
	translate(v = [0, 0, plate_thickness + 1]) {
		translate(v = [x, y, 0])
			fader_tang_hole(tang_hole_width, 71, plate_thickness + 2);
	}
}

module fader_60mm_snap_arm_array(x, y, spacing, count)
{
	if (use_fader_snap_arms > 0) {
		for (i = [0 : 1 : count - 1]) {
			translate(v = [x + i * spacing, y - 0.5 * fader_phys_length, 0])
				rotate(v = [0, 0, 1], a = 90)
					rotate(v = [1, 0, 0], a = 180)
						fader_snap_arms(fader_phys_length, fader_phys_width, fader_snap_arm_count);
		}
	}
}


module fader_60mm_hole_array(x, y, spacing, count)
{
	for (i = [0 : 1 : count - 1]) {
		fader_60mm_holes(x + i * spacing, y);
	}
}

module hemisphere(r)
{
	difference() {
		sphere(r);
		translate(v = [0, 0, -r])
			cube(size = [2 * r, 2 * r, 2 * r], center = true);
	}
}

module fader_60mm_array_insert(x, y, spacing, count)
{
	translate(v = [0, 0, plate_thickness]) {
	rotate(v = [1, 0, 0], a = 180) {
	union() {
		difference() {
			rotate(v = [1, 0, 0], a = 180)
				translate(v = [x, y - plate_height / 2, -plate_thickness])
					face_plate(plate_width, plate_height, plate_thickness);
			fader_60mm_hole_array(x + side_margin, y, spacing, count);
			if (1 == 0) {
			translate(v = [0, 0, plate_thickness]) {
				fader_screw_hole(4, -plate_height / 2 + 4, 0.5 * 3, 0.5 * 5, plate_thickness + 2, countersink);
				fader_screw_hole(4, plate_height / 2 - 4, 0.5 * 3, 0.5 * 5, plate_thickness + 2, countersink);
				fader_screw_hole((count + 1) * spacing - 4, -plate_height / 2 + 4, 0.5 * 3, 0.5 * 5, plate_thickness + 2, countersink);
				fader_screw_hole((count + 1) * spacing - 4, plate_height / 2 - 4, 0.5 * 3, 0.5 * 5, plate_thickness + 2, countersink);
			}
			}
			/* Corner screw holes */
			translate(v = [6, 0.5 * plate_height - 6, 0])
				cylinder(h = 20, r1 = 2, r2 = 2, center = true);
			translate(v = [6, -0.5 * plate_height + 6, 0])
				cylinder(h = 20, r1 = 2, r2 = 2, center = true);
			translate(v = [plate_width - 6, -0.5 * plate_height + 6, 0])
				cylinder(h = 20, r1 = 2, r2 = 2, center = true);
			translate(v = [plate_width - 6, 0.5 * plate_height - 6, 0])
				cylinder(h = 20, r1 = 2, r2 = 2, center = true);
		}
		fader_60mm_snap_arm_array(x + side_margin, y, spacing, count);
		translate(v = [0.5 * plate_width, 0.41 * plate_height, -0.5 * web_height])
			cube(size = [0.95 * plate_width, web_thickness, web_height], center = true);
		translate(v = [0.5 * plate_width, -0.41 * plate_height, -0.5 * web_height])
			cube(size = [0.95 * plate_width, web_thickness, web_height], center = true);

	}
	}
		/* panel_snap_arms(); */
	}
}

fader_60mm_array_insert(0, 0, fader_spacing, fader_count);


