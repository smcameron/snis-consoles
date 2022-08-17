
switch_width = 24.0; /* mm */
switch_height = 17.5; /* mm */

module switch_hole(x, y)
{
	translate(v = [x, y, 0])
		square(size = [switch_width, switch_height], center = true);
}

