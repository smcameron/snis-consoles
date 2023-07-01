
/* make a cantilever snap arm.  This is not super robust */

fader_snap_arm_fit_tolerance = 0.1;

module cantilever_snap_arm(ih, oh, w, back_angle, d)
{
	translate(v = [-w - fader_snap_arm_fit_tolerance, 0, 0])
	union() {
		cube(size = [w, d, oh]);
		translate(v = [0, 0, oh])
			rotate(v = [0, 1, 0], a = back_angle)
				translate(v = [0, 0, -oh * 1.2])
					cube(size = [w, d, oh * 1.2]);
		translate(v = [0.5 * w, 0, 0.9 * oh]) {
			difference() {
				rotate(v = [0, 1, 0], a = -45) {
					cube(size = [w * 1.3, d, 0.84 * oh - ih]);
				}
				translate(v = [-1.5 * w, -1, 0])
					cube(size = [w, 2 * d, 2 * (oh - ih)]);
			}
		}
	}
}

module tapered_cantilever_snap_arm(ih, oh, w, back_angle, d, taper_angle)
{
	difference() {
		cantilever_snap_arm(ih, oh, w, back_angle, d);
		translate(v = [-2.5 * w, -0.5 * d, 0])
			rotate(v = [1, 0, 0], a = -taper_angle)
				cube(size = [5 * w, 0.5 * d, 2 * oh]);
		translate(v = [-2.5 * w, d, 0])
			rotate(v = [1, 0, 0], a = taper_angle)
				cube(size = [5 * w, 0.5 * d, 2 * oh]);
		translate(v = [-5 * w, -2 * w, -2 * oh])
			cube(size = [10 * w, 2 * d, 2 * oh]);
	}
}


module fader_snap_arms(count)
{
	translate(v = [0, -5, 0])
		tapered_cantilever_snap_arm(8, 11, 1.2, 6, 10, 15);
	translate(v = [88, 0, 0])
			rotate(v = [0, 0, 1], a = 180)
				translate(v = [0, -5, 0])
					tapered_cantilever_snap_arm(8, 11, 1.2, 6, 10, 15);

	for (i = [1 : 1 : count]) {
		translate(v = [i * 88/(count + 1), -6, 0])
			rotate(v = [0, 0, 1], 90)
				translate(v = [0, -5, 0])
					tapered_cantilever_snap_arm(8, 11, 1.2, 6, 10, 15);
		translate(v = [i * 88/(count + 1), 6, 0])
			rotate(v = [0, 0, 1], -90)
				translate(v = [0, -5, 0])
					tapered_cantilever_snap_arm(8, 11, 1.2, 6, 10, 15);
	}
}

module tapered_snap_arm_row(ih, oh, w, back_angle, d, taper_angle, count, total_space)
{
	
	for (i = [1 : 1 : count]) {
		translate(v = [i * total_space / (count) , 0])
			rotate(v = [0, 0, 1], a = 90)
				tapered_cantilever_snap_arm(ih, oh, w, back_angle, d, taper_angle);
	}
}

/* tapered_cantilever_snap_arm(8, 11, 1.2, 6, 10, 15); */
/* fader_snap_arms(3); */
/* tapered_snap_arm_row(3, 6.6, 1.2, 7, 10, 15, 6, 100); */
