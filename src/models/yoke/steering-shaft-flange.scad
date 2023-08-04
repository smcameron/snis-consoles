
shaft_radius = (0.5 * 22.5);
flange_length = 15;
flange_lip_height = 4;
large_radius = shaft_radius * 1.5;
small_radius = shaft_radius * 1.2;
$fn = 100;

difference() {
	union() {
		translate(v = [0, 0, 0.5 * flange_length]) {
			cylinder(h = flange_length, r1 = small_radius, r2 = small_radius, center = true);
		}
		translate(v = [0, 0, 0.5 * flange_lip_height])
			cylinder(h = flange_lip_height, r1 = large_radius, r2 = large_radius, center = true);
	}
	translate(v = [0, 0, 0.5 * flange_length])
		cylinder(h = flange_length * 2, r1 = shaft_radius, r2 = shaft_radius, center = true);
	translate(v = [-20, 0, 10])
		rotate(v = [0, 1, 0], a = 90)
			cylinder(h = 40, r1 = 2, r2 = 2);
}
