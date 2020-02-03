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
buttondepth = 8;
holder_depth = 5;
holder_floor_thickness = 1.8;
button_case_size = 6;

module inner_cavity()
{
	union() {
		cube(size = [ depth + 5, innerwidth, innerheight ]);
		translate(v = [-10, thickness, thickness])
			cube(size = [ depth + 20, innerwidth - 2 * thickness, innerheight - 2 * thickness ]);
	}
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

module button_pusher()
{
	r = 0.5 * (innerheight - 2.5 * clearance);
	translate(v = [2.0 * r - thickness, 0.5 * (innerwidth), 0.5 * innerheight])
	rotate(v = [0, 1, 0], a = 90) {
		difference() {
			cylinder(r1 = 3.0, r2 = 3.0, h = 2);
			translate(v = [0, 0, 1.25])
				cylinder(r1 = 2.0, r2 = 2.0, h = 3);
		}
	}
}

module button_arms()
{
	r = 0.5 * (innerheight - 2.5 * clearance);
	rotate(v = [1, 0, 0], a = 90)
		translate(v = [r, 0.5 * (innerheight - 2.5 * clearance), 0.5 * (-innerwidth - 2.5 * clearance) - 2.75]) {
			difference() {
				cylinder(h = 6, r1 = r, r2 = r);
				translate(v = [0, 0, -1])
				cylinder(h = 8, r1 = r - thickness, r2 = r - thickness);
				translate(v = [-buttondepth - 10, -50, -50])
					cube(size = [buttondepth + 10, 100, 100]);
			}
		}
}

module button()
{
	translate(v = [20, 0, 0]) {
		rotate(v = [0, 1, 0], a = -90) {
			union() {
				difference() {
					cube(size = [buttondepth, innerwidth - 2.5 * clearance, innerheight - 2.5 * clearance]);
					translate(v = [-1, thickness, thickness])
						cube(size = [buttondepth + 5, innerwidth - 2 * thickness - 2.5 * clearance, innerheight - 2 * thickness - 2.5 * clearance]);
				}
				button_arms();
				button_pusher();
			}
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
				cube(size = [thickness * 2, width, height]);
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
					cube(size = [holder_floor_thickness, button_case_size + 1.5 * clearance, button_case_size + 1.5 * clearance]);
				button_lead_hole(2.25, 3.25);
				button_lead_hole(-2.25, 3.25);
				button_lead_hole(2.25, -3.25);
				button_lead_hole(-2.25, -3.25);
				led_hole(-8, 0);
				led_hole(8, 0);
				button_holder_rabbet(-20, 0.5 * outerheight + thickness - 0.25 * thickness, 50, thickness);
				button_holder_rabbet(-20, -0.5 * outerheight + 1.25 * thickness - clearance, 50, thickness);
				button_holder_rabbet_vert(-0.5 * outerwidth - clearance, -20, thickness * 2, 50);
				button_holder_rabbet_vert(0.5 * outerwidth - 2 * thickness + clearance, -20, thickness * 2, 50);
			}
		}
	}
}

case();
button();
button_holder();

