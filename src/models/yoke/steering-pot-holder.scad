
pot_base_radius = (0.5 * 16.5);
pot_base_depth = 6;
pot_shaft_hole_radius = 3.7;

interior_width = 59;
exterior_width = 75;
plate_thickness = 3.0;

tolerance = 0.75;

$fn = 100;

module pot_tab_hole()
{
	translate(v = [13, 30, -3])
		translate(v = [0, 8.5, 0])
			cylinder(r1 = 1.8, r2 = 1.8, h = 10);
}

module base_plate()
{
	union() {
		translate(v = [-5, 0, 0])
			cube(size = [plate_thickness, interior_width - tolerance, 30]);
		translate(v = [plate_thickness, -8, 0])
			cube(size = [plate_thickness, 15, 30]);
		translate(v = [plate_thickness, interior_width - 8, 0])
			cube(size = [plate_thickness, 15, 30]);
		translate(v = [-2, 0, 0])
			cube(size = [8, 8, 30]);
		translate(v = [-2, 50.2, 0])
			cube(size = [8, 8, 30]);
	}
}

module pot_plate()
{
	difference() {
		translate(v = [-5, 15, 0])
			cube(size = [25, 30, 4]);
		translate(v = [13, 30, -2])
			cylinder(r1 = pot_shaft_hole_radius, r2 = pot_shaft_hole_radius, h = 20);
		pot_tab_hole();
		translate(v = [-5.1, 0, -0.1])
			cube(size = [plate_thickness + 0.1, 100, 2 * plate_thickness]);
	}
}

module gusset()
{
	scale(v = [1, 1, 2]) {
	rotate(v = [0, 0, 1], a = 90)
	difference() {
		cube(size = [4, 10, 10]);
		translate(v = [-0.5, 0, 0])
			rotate(v = [1, 0, 0], a = 45)
				cube(size = [5, 20, 20]);
	}
	}
}

module gussets()
{
	translate(v = [8, 15, 4])
			gusset();
	translate(v = [8, 41, 4])
			gusset();
}

module screw_hole()
{
	rotate(v = [0, 1, 0], a = 90)
		cylinder(r1 = 1.75, r2 = 1.75, h = 100);
}

union() {
union() {
	base_plate();
}

translate(v = [0, -1, 0]) {
	pot_plate();
	gussets();
	translate(v = [-5 + plate_thickness, 5, 0])
		cube(size = [plate_thickness, 15, 30]);
	translate(v = [-5 + plate_thickness, 40, 0])
		cube(size = [plate_thickness, 15, 30]);
}
}


