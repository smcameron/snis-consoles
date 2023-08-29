
$fn = 64;
gauge_bottom_thickness = 4.5; /* mm */
servo_height = 23;
servo_width = 12;
servo_screw_distance = 27.5;
screw_hole_radius = 1.5;
gauge_radius = 40;
gauge_depth = 20;

module gauge()
{
	translate(v = [0, 0, 0.5 * gauge_bottom_thickness])
		difference() {
			cube(size = [2 * gauge_radius, 2 * gauge_radius, gauge_bottom_thickness], center = true);
			translate(v = [0, 0, -gauge_bottom_thickness])
				cylinder(r1 = gauge_radius, r2 = gauge_radius, h = gauge_depth);
			translate(v = [gauge_radius * 0.9, gauge_radius * 0.9, 0])
				cylinder(r1 = 2, r2 = 2, h = 20, center = true);
			translate(v = [-gauge_radius * 0.9, gauge_radius * 0.9, 0])
				cylinder(r1 = 2, r2 = 2, h = 20, center = true);
			translate(v = [-gauge_radius * 0.9, -gauge_radius * 0.9, 0])
				cylinder(r1 = 2, r2 = 2, h = 20, center = true);
			translate(v = [gauge_radius * 0.9, -gauge_radius * 0.9, 0])
				cylinder(r1 = 2, r2 = 2, h = 20, center = true);
		}

	difference() {
		cylinder(r1 = gauge_radius, r2 = gauge_radius, h = gauge_depth);
		translate(v = [0, 0, gauge_bottom_thickness])
			cylinder(r1 = gauge_radius - gauge_bottom_thickness,
				r2 = gauge_radius - gauge_bottom_thickness,
				h = gauge_depth + gauge_bottom_thickness);
		translate(v = [0, 0, gauge_depth - 8])
			cylinder(r1 = gauge_radius - 0.5 * gauge_bottom_thickness,
				r2 = gauge_radius - 0.5 * gauge_bottom_thickness,
				h = 0.5 * gauge_depth);
		translate(v = [-5, 0, 0])
		cube(size = [servo_height, servo_width, gauge_depth * 2], center = true);
		translate(v = [9, 0, 0])
			cylinder(r1 = screw_hole_radius, r2 = screw_hole_radius, h = 20, center = true);
		translate(v = [9 - servo_screw_distance, 0, 0])
			cylinder(r1 = screw_hole_radius, r2 = screw_hole_radius, h = 20, center = true);
	}
}


gauge();

