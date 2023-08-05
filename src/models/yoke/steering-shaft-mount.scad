steering_shaft_radius = 11;
steering_shaft_tolerance = 0.35;
steering_shaft_elevation = 20; // fix this


/* mount_height - mount_radius must equal 20 */
mount_radius = steering_shaft_radius + 5;
mount_height = 41.3;
mount_width = mount_radius * 2;
mount_thickness = 10;
$fn = 100;


module screw_hole()
{
	translate(v = [0, 0, 7])
		cylinder(r1 = 4.25, r2 = 4.25, h = 50);
	cylinder(r1 = 2, r2 = 2, h = 50);
}


module shaft_mount()
{
	union() {
	difference() {
		union() {
			translate(v = [0, 0, mount_height - mount_radius])
				rotate(v = [1, 0, 0], a = 90) {
						cylinder(r1 = mount_radius, r2 = mount_radius, h = mount_thickness);
				}
			translate(v = [-mount_width / 2, -mount_thickness, 0])
				cube(size = [mount_width, mount_thickness, mount_height - mount_radius]);
		}
		translate(v = [0, 3, mount_height - mount_radius])
			rotate(v = [1, 0, 0], a = 90)
				cylinder(r1 = steering_shaft_radius + steering_shaft_tolerance,
					r2 = steering_shaft_radius + steering_shaft_tolerance, h = 2 * mount_thickness);
	}
	difference() {
		translate(v = [-mount_width / 2, -1, 0])
			cube(size = [mount_width, 30, 5]);
		/* translate(v = [-mount_width / 3, 7, -5])
			screw_hole(); */
		translate(v = [0, 8, -5])
			screw_hole();
		translate(v = [mount_width / 3, 23, -5])
			screw_hole();
		translate(v = [-mount_width / 3, 23, -5])
		screw_hole();
	}
	translate(v = [-mount_width / 2, 0, 2.0])
		rotate(v = [1, 0, 0], a = 45)
			cube(size = [mount_width, 4, 4]);
	translate(v = [-16, 5, 0])
		rotate(v = [1, 0, 0], a = 45)
			cube(size = [4, 7, 15]);
	translate(v = [12, 5, 0])
		rotate(v = [1, 0, 0], a = 45)
			cube(size = [4, 7, 15]);
	}
}

translate(v = [0, -1, 0])
	shaft_mount();

