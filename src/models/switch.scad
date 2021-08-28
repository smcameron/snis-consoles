$fn = 64;

/* This is a 3d printable rough facsimile of a tellite switch that
 * can be made with a couple LEDs, some laser cut acrylic, and a cheap
 * tactile momentary switch.
 */

/* By changing rows and cols, you can make gangs of switches. */
print_case=1;
print_button=1;
print_button_holder=1;
rows=1;
cols=1;

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
		cube(size = [ depth + 6.5, innerwidth + 2 * clearance, innerheight + 2 * clearance ]);
		translate(v = [-10, thickness + clearance, thickness + clearance])
			cube(size = [ depth + 20, innerwidth - 2 * thickness, innerheight - 2 * thickness ]);
	}
}

module outer_case()
{
	union() {
		cube(size = [ depth + 1, outerwidth, outerheight ]);
		translate(v = [0, -thickness, -thickness])
			cube(size = [ thickness, outerwidth + thickness * 2, outerheight + thickness * 2 ]);
	}
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
			translate(v = [0, 0, 0.4])
			cylinder(r1 = 3.0, r2 = 3.0, h = 1.0);
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

module friction_arm(x, y)
{
	translate(v = [0, x, y])
		cube(size = [7, 3, 2]);
}

module button_holder()
{
	translate(v = [-20, 0, 0]) {
		rotate(v = [0, 1, 0], a = -90) {
			difference() {
				cube(size = [holder_floor_thickness * 2, outerwidth, outerheight]);
				translate(v = [0.5 * holder_floor_thickness + clearance, 0.5 * (outerwidth - button_case_size - clearance),
									0.5 * (outerheight - button_case_size - clearance)])
					cube(size = [holder_floor_thickness * 2, button_case_size + 1.5 * clearance, button_case_size + 1.5 * clearance]);
				button_lead_hole(2.25, 3.25);
				button_lead_hole(-2.25, 3.25);
				button_lead_hole(2.25, -3.25);
				button_lead_hole(-2.25, -3.25);
				led_hole(-6.5, 0);
				led_hole(6.5, 0);
				button_holder_rabbet(-20, 0.5 * outerheight + thickness - 0.25 * thickness, 50, thickness);
				button_holder_rabbet(-20, -0.5 * outerheight + 1.25 * thickness - clearance, 50, thickness);
				button_holder_rabbet_vert(-0.5 * outerwidth - clearance, -20, thickness * 2, 50);
				button_holder_rabbet_vert(0.5 * outerwidth - 2 * thickness + clearance, -20, thickness * 2, 50);
			}
			friction_arm(1.5 * thickness + clearance, thickness + clearance);
			friction_arm(outerwidth - (1.5 * thickness + clearance) - 3, thickness + clearance);
			friction_arm(1.5 * thickness + clearance, outerheight - thickness - clearance - 2.2);
			friction_arm(outerwidth - (1.5 * thickness + clearance) - 3, outerheight - thickness - clearance - 2.2);
		}
	}
}

module print_cases()
{
	if (print_case != 0) {
		for (i = [0 : 1 : rows - 1]) {
			translate(v = [outerheight * 0.95 * i, 0, 0]) {
				for (j = [0 : 1 : cols - 1]) {
					translate(v = [0, outerwidth * 0.95 * j, 0]) {
						case();
					}
				}
			}
		}
	}
}

module print_buttons()
{
	if (print_button != 0) {
		for (i = [0 : 1 : rows - 1]) {
			translate(v = [outerheight * i, 0, 0]) {
				for (j = [0 : 1 : cols - 1]) {
					translate(v = [0, outerwidth * j, 0]) {
						button();
					}
				}
			}
		}
	}
}

module print_button_holders()
{
	if (print_button_holder != 0) {
		for (i = [0 : 1 : rows - 1]) {
			translate(v = [outerheight * 1.1 * i, 0, 0]) {
				for (j = [0 : 1 : cols - 1]) {
					translate(v = [0, outerwidth * 1.1 * j, 0]) {
						button_holder();
					}
				}
			}
		}
	}
}


print_cases();
print_buttons();
print_button_holders();

