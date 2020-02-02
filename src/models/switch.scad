$fn = 64;

/* This is (will be) a 3d printable rough facsimile of a tellite switch that
 * can be made with a couple LEDs, some laser cut acrylic, and a cheap
 * tactile momentary switch.
 */

outerwidth = 23.368;  
outerheight= 17.018;
thickness = 1.25;
innerwidth = outerwidth - 2 * thickness;
innerheight = outerheight - 2 * thickness;
depth = 20;
clearance = 0.2;
buttondepth = 10;
holder_depth = 5;
holder_floor_thickness = 1.8;
button_case_size = 6;

module inner_cavity()
{
	cube(size = [ depth + 5, innerwidth, innerheight ]);
	translate(v = [-10, thickness, thickness])
		cube(size = [ depth + 20, innerwidth - 2 * thickness, innerheight - 2 * thickness ]);
}

module outer_case()
{
	cube(size = [ depth, outerwidth, outerheight ]);
}

module case()
{
	rotate(v = [0, 1, 0], a = -90) {
		difference() {
			outer_case();
			translate(v = [ thickness, thickness, thickness ])
				inner_cavity();
		}
	}
}

module button()
{
	translate(v = [20, 0, 0]) {
		rotate(v = [0, 1, 0], a = -90) {
			cube(size = [buttondepth, innerwidth - 2 * clearance, innerheight - 2 * clearance]);
		}
	}
}

module button_lead_hole(x, y)
{
	translate(v = [0, x, y]) {
		translate(v = [0, outerwidth * 0.5, outerheight * 0.5]) {
			rotate(v = [0, 1, 0], a = 90)
				cylinder(h = 20, r1 = 1.25, r2 = 1.25, center = true);
		}
	}
}

module led_hole(x, y)
{
	translate(v = [0, x, y]) {
		translate(v = [0, outerwidth * 0.5, outerheight * 0.5]) {
			rotate(v = [0, 1, 0], a = 90)
				cylinder(h = 20, r1 = 2.5 + 0.5 * clearance, r2 = 2.5 + 0.5 * clearance, center = true);
		}
	}
}

module button_holder_rabbet(x, y, width, height)
{
	translate(v = [holder_floor_thickness * 2 - thickness + clearance, x, y]) {
		translate(v = [0, outerwidth * 0.5, outerheight * 0.5]) {
			rotate(v = [0, 1, 0], a = 90)
				cube(size = [thickness, width, height]);
		}
	}
}

module button_holder_rabbet_vert(x, y, width, height)
{
	translate(v = [holder_floor_thickness * 2 - thickness + clearance, x, y]) {
		translate(v = [0, outerwidth * 0.5, outerheight * 0.5]) {
				cube(size = [thickness, width, height]);
		}
	}
}


module button_holder()
{
	translate(v = [-20, 0, 0]) {
		rotate(v = [0, 1, 0], a = -90) {
			difference() {
				cube(size = [holder_floor_thickness * 2, outerwidth, outerheight]);
				translate(v = [holder_floor_thickness + clearance, 0.5 * (outerwidth - button_case_size - clearance),
									0.5 * (outerheight - button_case_size - clearance)])
					cube(size = [holder_floor_thickness, button_case_size + clearance, button_case_size + clearance]);
				button_lead_hole(2.25, 3.25);
				button_lead_hole(-2.25, 3.25);
				button_lead_hole(2.25, -3.25);
				button_lead_hole(-2.25, -3.25);
				led_hole(-8, 0);
				led_hole(8, 0);
				button_holder_rabbet(-20, 0.5 * outerheight, 50, thickness);
				button_holder_rabbet(-20, -0.5 * outerheight + thickness, 50, thickness);
				button_holder_rabbet_vert(-0.5 * outerwidth - clearance, -20, thickness * 2, 50);
				button_holder_rabbet_vert(0.5 * outerwidth - 2 * thickness + clearance, -20, thickness * 2, 50);
			}
		}
	}
}

case();
button();
button_holder();

