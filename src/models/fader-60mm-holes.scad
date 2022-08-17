
fader_travel = 67.0; /* mm */
fader_slot_width = 2.0; /* mm */
distance_between_screw_holes = 85.0; /* mm */
screw_hole_diameter = 3.0; /* mm */
$fn = 32;

module fader60mm(x, y)
{
	translate(v = [x, y, 0]) {
		square(size = [fader_travel, fader_slot_width], center = true);
		translate(v = [distance_between_screw_holes / 2.0, 0, 0])
			circle(d = screw_hole_diameter);
		translate(v = [-distance_between_screw_holes / 2.0, 0, 0])
			circle(d = screw_hole_diameter);
	}
}

module fader_array(x, y, vertical_spacing, count)
{
	for (i = [0 : count - 1]) {
		fader60mm(x, y + vertical_spacing * i);
	}
}

