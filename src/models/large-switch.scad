

width = 30;
height = 20;
thickness = 1.5;
outer_width = width + 2 * thickness;
outer_height = height + 2 * thickness;
button_frame_width = 3;
button_pusher_frame_depth = 7;
main_case_depth = 26.5;
clearance = 0.2;
button_pusher_length = 19.35;
holder_floor_thickness = 1.8;

$fn=100;

module centered_cube(x, y, z)
{
	translate(v = [-0.5 * x, -0.5 * y, 0])
		cube(size = [x, y, z]);
}

module button_frame()
{
	button_frame_outer_width = width + thickness + button_frame_width;
	button_frame_inner_width = button_frame_outer_width - 2 * button_frame_width;
	button_frame_outer_height = height + thickness + button_frame_width;
	button_frame_inner_height = button_frame_outer_height - 2 * button_frame_width;
	difference() {
		centered_cube(button_frame_outer_width, button_frame_outer_height, thickness);
		translate(v = [0, 0, -0.5 * thickness])
			centered_cube(button_frame_inner_width, button_frame_inner_height, 2 * thickness);
	}
}

module button_main_case()
{
	translate(v = [0, 0, thickness])
	difference() {
		centered_cube(outer_width, outer_height, main_case_depth);
		translate(v = [0, 0, -5 * thickness])
			centered_cube(width, height, 10 + main_case_depth);
	}
}

module button_case()
{
	union() {
		button_frame();
		button_main_case();
	}
}

module button_pusher_frame()
{
	outer_width = width - 2.5 * clearance;
	outer_height = height - 2.5 * clearance;
	inner_width = outer_width - 2 * thickness;
	inner_height = outer_height - 2 * thickness;
	difference() {
		centered_cube(outer_width, outer_height, button_pusher_frame_depth);
		translate(v = [0, 0, -0.5 * button_pusher_frame_depth])
			centered_cube(inner_width, inner_height, 2 * button_pusher_frame_depth);
	}
}

module button_pusher_handle()
{
	outer_radius = 0.5 * (height - 2.5 * clearance);
	inner_radius = outer_radius - thickness;
	cyl_height = 6;

	rotate(v = [0, 0, 1], a = 90)
	rotate(v = [1, 0, 0], a = -90)
	difference() {
		cylinder(r1 = outer_radius, r2 = outer_radius, h = cyl_height, center = true);
		cylinder(r1 = inner_radius, r2 = inner_radius, h = 2 * cyl_height, center = true);
		translate(v = [-1.5 * inner_radius, 0, -cyl_height])
			cube(size = [3 * inner_radius, 3 * inner_radius, 3 * cyl_height]);
	}
}

module button_pusher_head()
{
	difference() {
		translate(v = [0, 0, 0.4])
		cylinder(r1 = 3.0, r2 = 3.0, h = 1.0);
		translate(v = [0, 0, 1.25])
			cylinder(r1 = 2.0, r2 = 2.0, h = 3);
	}
}

module button_pusher_handle_extensions()
{
	outer_radius = 0.5 * (height - 2.5 * clearance);
	translate(v = [0, -0.5 * height + 2 * thickness / 3, 0])
		centered_cube(6, thickness, button_pusher_length - outer_radius);
	translate(v = [0, 0.5 * height - 2 * thickness / 3, 0])
		centered_cube(6, thickness, button_pusher_length - outer_radius);
}

module button_pusher_handle_and_head()
{
	outer_radius = 0.5 * (height - 2.5 * clearance);
	union() {
		button_pusher_handle();
		translate(v = [0, 0, outer_radius - 1])
			button_pusher_head();
	}
}

module button_pusher()
{
	outer_radius = 0.5 * (height - 2.5 * clearance);
	union() {
		translate(v = [0, 0, button_pusher_length - outer_radius - 1]) {
			button_pusher_handle_and_head();
		}
		button_pusher_handle_extensions();
		button_pusher_frame();
	}
}

module button_lead_hole(x, y)
{
	translate(v = [0, x, y]) {
		translate(v = [0, outer_width * 0.5, outer_height * 0.5]) {
			rotate(v = [0, 1, 0], a = 90)
				cylinder(h = 20, r1 = 1.25, r2 = 1.25, center = true);
		}
	}
}

module led_hole(x, y)
{
	translate(v = [0, x, y]) {
		translate(v = [0, outer_width * 0.5, outer_height * 0.5]) {
			rotate(v = [0, 1, 0], a = 90)
				cylinder(h = 20, r1 = 2.8 + 0.5 * clearance, r2 = 2.8 + 0.5 * clearance, center = true);
		}
	}
}

module friction_arms(x, y)
{
	translate(v = [x, y, 0])
		centered_cube(3, 3, 10);
	translate(v = [x, -y, 0])
		centered_cube(3, 3, 10);
	translate(v = [-x, -y, 0])
		centered_cube(3, 3, 10);
	translate(v = [-x, y, 0])
		centered_cube(3, 3, 10);
}

module button_holder_holes()
{
	translate(v = [16.5, 11.5, 0])
	rotate(v = [1, 0, 0], a = 90)
	rotate(v = [0, 0, 1], a = 90) {
		button_lead_hole(2.25, 3.25);
		button_lead_hole(-2.25, 3.25);
		button_lead_hole(2.25, -3.25);
		button_lead_hole(-2.25, -3.25);
		led_hole(-6.5, 0);
		led_hole(6.5, 0);
	}
}

module button_holder()
{
	difference() {
		union() {
			centered_cube(width - 2 * clearance, height - 2 * clearance, 4.0 * thickness);
			centered_cube(outer_width, outer_height, 2.0 * thickness);
		}
		button_holder_holes();
		translate(v = [0, 0, 1.5 * thickness])
			centered_cube(6.5, 6.5, 4 * thickness);
	}
	translate(v = [0, 0, 4 * thickness])
		friction_arms(0.5 * width - 1.5 - 0.5 * clearance, 0.5 * height - 1.5 - 0.5 * clearance);
}


module lens_blank()
{
	union() {
		/* centered_cube(width - 2 * clearance, height - 2 * clearance, 4.0 * thickness); */
		centered_cube(width - 2 * clearance, height - 2 * clearance, 3.175); /* 1/8th inch thick */
		/* centered_cube(outer_width, outer_height, 2.0 * thickness); */
	}
}

translate(v = [0, 30, 0])
	button_pusher();
button_case();
translate(v = [50, 0, 0])
button_holder();

/* lens_blank(); */

