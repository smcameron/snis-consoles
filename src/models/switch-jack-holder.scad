
tolerance = 0.2;
jack_depth = 10.3 + tolerance;
jack_width = 10.3 + tolerance;
jack_height = 17.5 + tolerance;
jack_tab_depth = 4.56 + tolerance;
jack_tab_width = 1.2 + tolerance;
jack_tab_height = 1.67 + tolerance;
jack_notch_height = 3.66 + tolerance;
jack_notch_width = 1.7 + tolerance;

$fn = 100;

module jack_shape()
{
	difference() {
		union() {
			cube(size = [jack_depth, jack_width, jack_height]);
			translate(v = [jack_tab_depth - jack_tab_width / 2, -jack_tab_height, 0])
				cube(size = [jack_tab_height, jack_tab_height + 1, jack_height]);
		}
		translate(v = [-1, -(jack_notch_width + 4 *tolerance), -1])
			cube(size = [jack_depth * 2, jack_notch_width * 2, 1 + jack_notch_height]);
	}
}

module bulge() {

	difference() {
	translate(v = [4, 0, 0]) {
		union() {
			cylinder(r1 = 4, r2 = 4, h = jack_height + 5);
		}
	}
	translate(v = [0, -2, -1])
		cube(size = [10, 10, jack_height + 10]);
	}
}

module jack_holder()
{
	difference()  {
		cube(size = [jack_depth + 5, jack_width + 5, jack_height + 5]);
		translate(v = [-1, 2.5, 5.1])
			jack_shape();
		translate(v = [8, jack_width / 2, 5])
			cube(size = [10, 5, jack_height * 2]);
	}
}

module jack_legs()
{
	translate(v = [jack_depth, 0, 0])
		cube(size = [30, 4, 20]);
	hull() {
		translate(v = [jack_depth, jack_width + 2, 0])
			cube(size = [4, 3, 20]);
		translate(v = [jack_depth + 26, 22.86 - 4, 0])
			cube(size = [4, 3, 20]);
	}
}

union() {
	jack_holder();
	jack_legs();
	translate(v = [0, 2.5, 0])
		bulge();
}


