
shaft_radius = (0.5 * 22.5);
outer_small_radius = shaft_radius * 1.5;
outer_large_radius = shaft_radius * 1.9;
$fn = 100;

module screw_hole()
{
	cylinder(h = 30, r1 = 2, r2 = 2, center = true);
}

module face_plate()
{
	width = 50;
	length = 110;
	thickness = 5;
	difference() {
		cube(size = [width, length, thickness], center = true);
		translate(v = [5 + -width / 2, 5 + -length / 2, 0])
			screw_hole();
		translate(v = [-5 + width / 2, 5 + -length / 2, 0])
			screw_hole();
		translate(v = [-5 + width / 2, -5 + length / 2, 0])
			screw_hole();
		translate(v = [5 + -width / 2, -5 + length / 2, 0])
			screw_hole();
	}
}

module shroud_cavity()
{
	rotate(v = [1, 0, 0], a = 100) {
		translate(v = [0, 0, -5])
			cylinder(h = 100, r1 = shaft_radius, r2 = shaft_radius);
		translate(v = [0, 0, 5])
			cylinder(h = 100, r1 = 1.2 * shaft_radius, r2 = 1.5 * shaft_radius);
	}
}

module bottom_cutter()
{
	translate(v = [-50, -120, -42])
		rotate(v = [1, 0, 0], a = -15)
			cube(size = [100, 150, 50]);
}

module shroud()
{
	difference() {
		union() {
			rotate(v = [1, 0, 0], a = 100) {
				cylinder(h = 90, r1 = outer_small_radius, r2 = outer_large_radius); 
			}
			translate(v = [0, -40, -10])
				rotate(v = [1, 0, 0], a = -15)
					face_plate();
		}
		shroud_cavity();
		bottom_cutter();
	}
}

module shroud_slicer()
{
	translate(v = [0, -150, -50])
		cube(size = [100, 200, 100]);
}

module shroud_right_half()
{
	difference() {
		shroud();
		shroud_slicer();
	}
}

module shroud_left_half()
{
	mirror(v = [1, 0, 0])
		shroud_right_half();
}


rotate(v = [0, 1, 0], a = 90)
	shroud_right_half();

translate(v = [-60, 0, 0])
	rotate(v = [0, 1, 0], a = -90)
		shroud_left_half();
