
toggle_switch_diameter = 12; /* mm */

module toggle_switch_hole(x, y)
{
	translate(v = [x, y, 0])
		circle(d = toggle_switch_diameter);
}

