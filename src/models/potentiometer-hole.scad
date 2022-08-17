
potentiometer_diameter = 6.5; /* mm */

module potentiometer_hole(x, y)
{
	translate(v = [x, y, 0])
		circle(d = potentiometer_diameter);
}

