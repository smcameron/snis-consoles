
$fn = 8;

module horizontal_crossbar(r)
{
	translate(v = [0, 0, 0.925 * r])
		rotate(v = [1, 0, 0], a = 0.5 * 45)
			rotate(v = [0, 1, 0], a = 90) {
				hull() {
					cylinder(r1 = r, r2 = r, h = 20, center = true);	
					cylinder(r1 = 0.5 * r, r2 = 0.5 * r, h = 26, center = true);	
				}
			}
}

module tang_hole()
{
	translate(v = [0, 0, 16])
		cube(size = [1.35, 4.35, 10.5], center = true);
}

module shaft()
{
	difference() {
		hull() {
			translate(v = [0, 0, 5])
				cylinder(r1 = 2, r2 = 2, h = 10);
			translate(v = [0, 0, 20])
				scale(v = [1.2, 1.5, 1.2])
					cylinder(r1 = 3, r2 = 3, h = 1);
		}
	}
}

module shaft_extension()
{
	translate(v = [0, 0, 20.5])
	difference() {
		cylinder(r1 = 4, r2 = 5, h = 7.5);
		translate(v = [0, 0, -1])
			cylinder(r1 = 3.5, r2 = 3.5, h = 10);
	}
}

difference() {
union() {
	horizontal_crossbar(5);
	shaft();
	shaft_extension();
}
tang_hole();
}

