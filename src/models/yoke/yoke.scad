$fn = 100;

print_hub_face = 1;
print_hub_back = 1;
print_left_handle = 1;
print_right_handle = 1;
show_relative_positioning = 0;

/* pipe dimensions */
pipe_outer_radius = 10;
pipe_clearance = 0.5;

steering_shaft_radius = 15.0;

module finger_notch()
{
	rotate(v = [0,0, 1], a = -135)
	rotate_extrude(angle = 90, convexity = 2)
		translate(v = [-40, 0, 0])
			circle(r = 14);
}

module finger_notch_stack()
{
	translate(v = [0, 0, 30])
	rotate(v = [1, 0, 0], a = -13)
	for (i = [0:1:3])
		translate(v = [3 + i * 5, -6, i * 25])
			finger_notch();
}

module handle_bottom()
{
	translate(v = [20, 0, 0])
		rotate(v = [1, 0, 0], a = 90)
			rotate_extrude(angle = 115, convexity=2)
				translate(v = [-20, 0, 0])
					scale(v = [0.8, 1.0, 1.0])
						circle(r = 20);

	hull() {
	translate(v = [20.0, 0, 0])
	rotate(v = [0, 1, 0], a = 90 - 25)
		translate(v = [20, 0, 0])
			scale(v = [0.8, 1.0, 1.0])
				cylinder(r1 = 20, r2 = 20, h = 2);
	translate(v = [30.0, 0, 5])
	rotate(v = [0, 1, 0], a = 90 - 25)
		translate(v = [20, 0, 0])
				cylinder(r1 = 13, r2 = 13, h = 2);
	}
}

module connector_pipe(l)
{
	cylinder(r1 = pipe_outer_radius, r2 = pipe_outer_radius, h = l); 
}

module left_handle()
{
	difference() {
		union() {
			handle_bottom();
			hull() {
			scale(v = [0.8, 1.0, 1.0])
				cylinder(r1 = 20, r2 = 20, h = 2);
			translate(v = [15, 25, 115])
				scale(v = [0.75, 1.0, 1.0]) {
					scale(v = [1, 1, 0.75])
						sphere(r = 20);
				}
			}
		}
		finger_notch_stack();
	}
}

module center_shape()
{
	hull() {
		cylinder(r1 = 30, r2 = 30, h = 30);
		translate(v = [40, 0, 0])
		cylinder(r1 = 20, r2 = 20, h = 30);
	}
}

module starbeam()
{
	scale(v = [0.1, 1, 1])
		rotate(v = [0, 0, 1], a = 45)
			translate(v = [0, 0, 0.5])
				cube(size = [10, 10, 1], center = true);
}

module four_point_star()
{
	starbeam();
	rotate(v = [0, 0, 1], a = 90)
		starbeam();
}

module eight_point_star()
{
	four_point_star();
	rotate(v = [0, 0, 1], a = 45)
		scale(v = [0.6, 0.6, 1])
			four_point_star();
}

module logo()
{
	scale(v = [2.2, 2.2, 2.2]) {
		difference() {
			cylinder(r1 = 10, r2 = 10, h = 1);
			translate(v = [0, 1, -1])
				cylinder(r1 = 10, r2 = 10, h = 10);
		}
		translate(v = [0, -10, 0])
			eight_point_star();
	}
}

module logo_text()
{
	translate(v = [0, 17, 26])
		rotate(v = [0, 0, 1], a = -90)
			linear_extrude(10)
				scale(v = [0.5, 0.5, 0.5])
					text("Z E N A B I");
	translate(v = [-8, 22, 26])
		rotate(v = [0, 0, 1], a = -90)
			linear_extrude(10)
				scale(v = [0.5, 0.5, 0.5])
					text("SPACECRAFT");
}

module hub()
{
	difference() {
		hull() {
			center_shape();
			translate(v = [0, 0, -3])
			scale(v = [0.9, 0.9, 1.3])
				center_shape();
		}
		translate(v = [0, 0, 35])
			scale(v = [0.85, 0.85, 1.25])
				center_shape();
		translate(v = [40, 0, -80])
			rotate(v = [0, 1, 0], a = -10)
				cylinder(r1 = steering_shaft_radius + pipe_clearance, r2 = steering_shaft_radius + pipe_clearance, h = 100);
	}
	translate(v = [4, 0, 34])
		rotate(v = [0, 0, 1], a = 90)
			logo();
	logo_text();
}

module right_handle()
{
	mirror(v = [1, 0, 0])
		left_handle();
}

module left_connector_pipe()
{
	translate(v = [10, 0, -26])
		rotate(v = [0, 1, 0], a = 65)
			connector_pipe(110);
}

module right_connector_pipe()
{
	translate(v = [240, 0, -26])
		rotate(v = [0, 1, 0], a = -65)
			connector_pipe(110);
}

module positioned_hub()
{
	difference() {
		translate(v = [125, 15, 20])
			rotate(v = [1, 0, 0], a = 80)
				rotate(v = [0, 0, 1], a = 90)
					hub();
		left_connector_pipe();
		right_connector_pipe();
	}
}

module positioned_left_handle()
{
	difference() {
		left_handle();
		left_connector_pipe();
	}
}

module positioned_right_handle()
{
	difference() {
		translate(v = [250, 0, 0])
			right_handle();
		right_connector_pipe();
	}
}

module printable_hub_face()
{
	difference() {
		translate(v = [-100, 0, -15])
			rotate(v = [1, 0, 0], a = -80)
				positioned_hub();
		translate(v = [-10, -10, -50])
			cube(size = [75, 100, 50]);
	}
}

module printable_hub_back()
{
	rotate(v = [0, 1, 0], 180)
	difference() {
		translate(v = [-100, 0, -15])
			rotate(v = [1, 0, 0], a = -80)
				positioned_hub();
		translate(v = [-10, -10, 0])
			cube(size = [75, 100, 50]);
	}
}

module printable_right_handle_front()
{
	translate(v = [-140, 0, 0])
	difference() {
		rotate(v = [1, 0, 0], a = -80)
			positioned_right_handle();
		translate(v = [100, -50, -50])
			cube(size = [200, 200, 50]);
	}
}

module printable_right_handle_back()
{
	rotate(v = [0, 1, 0], a = 180)
	translate(v = [-250, 0, 0])
	difference() {
		rotate(v = [1, 0, 0], a = -80)
			positioned_right_handle();
		translate(v = [100, -50, 0])
			cube(size = [200, 200, 50]);
	}
}

module printable_left_handle_front()
{
	difference() {
		rotate(v = [1, 0, 0], a = -80)
			positioned_left_handle();
		translate(v = [-50, -50, -50])
			cube(size = [200, 200, 50]);
	}
}

module printable_left_handle_back()
{
	translate(v = [50, 100, 0])
	rotate(v = [1, 0, 0], a = 180)
	difference() {
		rotate(v = [1, 0, 0], a = -80)
			positioned_left_handle();
		translate(v = [-50, -50, 0])
			cube(size = [200, 200, 50]);
	}
}

if (show_relative_positioning) {
	positioned_right_handle();
	positioned_left_handle();
	positioned_hub();
}

if (print_hub_face) {
	translate(v = [250, -100, 0])
		printable_hub_face();
}

if (print_hub_back) {
	translate(v = [300, 0, 0])
		printable_hub_back();
}


if (print_right_handle) {
	translate(v = [100, 0, 0]) {
		printable_right_handle_front();
		printable_right_handle_back();
	}
}

if (print_left_handle) {
	printable_left_handle_front();
	printable_left_handle_back();
}
