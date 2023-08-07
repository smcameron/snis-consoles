plate_thickness = 3;
mounting_height = 25;
$fn = 100;

module screw_hole()
{
	translate(v = [0, 0, 7])
		cylinder(r1 = 4.25, r2 = 4.25, h = 50);
	cylinder(r1 = 2, r2 = 2, h = 50);
}

module flange()
{
	union() {
		difference() {
			cube(size = [30, 30, plate_thickness]);
			translate(v = [5, 5, -5])
				screw_hole();
			translate(v = [25, 5, -5])
				screw_hole();
			translate(v = [15, 20, -5])
				screw_hole();
		}
		translate(v = [0, 30, 0])
			rotate(v = [0, 0, 1], a = -90)
				cube(size = [plate_thickness, 30, mounting_height]);
	}
}

module gusset()
{
	rotate(v = [1, 0, 0], a = 45)
		cube(size = [30, 1.2 * plate_thickness, 1.2 * plate_thickness]);
}

module gussets()
{
	translate(v = [0, 27, 0.3])
		gusset();
	translate(v = [0, 30, 19.5])
		gusset();
	translate(v = [0, 60, 19.5])
		gusset();
	translate(v = [0, 63, 0.3])
		gusset();
}

module top_plate()
{
	translate(v = [0, 30, mounting_height - plate_thickness]) {
		difference() {
			cube(size = [30, 30, plate_thickness]);
			translate(v = [15, 15, -5])
				cylinder(r1 = 3.7, r2 = 3.7, h = 10);
			translate(v = [15, 15 + 8, -5])
				cylinder(r1 = 1.8, r2 = 1.8, h = 10);
		}
	}
}

translate(v = [0, 0, 30])
rotate(v = [0, 1, 0], a = 90)
union() {
	flange();
	translate(v = [0, 90, 0])
		mirror(v = [0, 1, 0])
			flange();
	top_plate();
	gussets();
}
