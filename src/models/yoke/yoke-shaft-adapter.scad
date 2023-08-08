
shaft_radius = (0.5 * 22.5);
flange_length = 40;
flange_lip_height = 15;
large_radius = shaft_radius * 1.5;
small_radius = shaft_radius * 1.2;
$fn = 100;

module adapter()
{
	union() {
		difference() {
			union() {
				translate(v = [0, 0, 0.5 * flange_length]) {
					cylinder(h = flange_length, r1 = small_radius, r2 = small_radius, center = true);
				}
				rotate(v = [0, 1, 0], a = 10)
					translate(v = [0, 0, 0.3 * flange_lip_height])
						cylinder(h = flange_lip_height, r1 = large_radius, r2 = 0.8 * small_radius, center = true);
			}
			translate(v = [0, 0, 30])
				cylinder(h = 41, r1 = shaft_radius, r2 = shaft_radius, center = true);
			translate(v = [-20, 0, 15])
				rotate(v = [0, 1, 0], a = 90)
					cylinder(h = 40, r1 = 2, r2 = 2);
			translate(v = [-20, 0, 30])
				rotate(v = [0, 1, 0], a = 90)
					cylinder(h = 40, r1 = 2, r2 = 2);
		}
		translate(v = [0, 0, -15])
			cylinder(r1 = 11, r2 = 11, h = 25);
		translate(v = [0, 0, 0])
			cylinder(r1 = 14, r2 = 13, h = 10);
	}
}

module top_half_adapter()
{
	difference() {
		rotate(v = [1, 0, 0], a = 90)
			adapter();
		translate(v = [-50, -50, -20])
			cube(size = [100, 100, 20]);
	}
}

module bottom_half_adapter()
{
	difference() {
		rotate(v = [1, 0, 0], a = -90)
			adapter();
		translate(v = [-50, -50, -20])
			cube(size = [100, 100, 20]);
	}
}

top_half_adapter();
translate(v = [35, -25, 0])
	bottom_half_adapter();
