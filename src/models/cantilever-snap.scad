
/* make a cantilever snap arm.  This is not super robust.
 * The best way to use this is to only use snap_arm(scale_factor = xxx)
 */

$fn=100;

module cantilever_snap_head(width, depth)
{
	height = width;

	difference() {
		translate(v = [-0.5 * width, -0.5 * depth, 0])
			cube(size = [width, depth, height]);
		translate(v = [0, -0.5 * depth - 1, 0]) {
			rotate(v = [0, 1, 0], a = 45)
				cube(size = [width, 2 * depth, height]);
			translate(v = [width / 2, -1, 0.5 * height])
				rotate(v = [0, 1, 0], a = -45)
					cube(size = [width, 2 * depth, height]);
		}
	}
}

module cantilever_snap_arm_base(base_width, depth, height)
{
	difference() {
		translate(v = [-base_width, -0.5 * depth, 0])
			cube(size = [base_width, depth, height]);
		translate(v = [-base_width, -0.5 * depth, 0])
			rotate(v = [0, 1, 0], a = 10)
				translate(v = [-2 * base_width, -0.5 * depth, 0])
					cube(size = [2 * base_width, 2 * depth, 2 * height]);
	}
}

module tapered_cantilever_snap_arm_base(base_width, depth, height)
{

	difference() {
		cantilever_snap_arm_base(base_width, depth, height);
		translate(v = [0, 0.5 * depth, 0])
			rotate(v = [1, 0, 0], a = 7)
				translate(v = [-1.5 * base_width, 0, 0])
					cube(size = [2 * base_width, depth, 2 * height]);
		translate(v = [-1.5 * base_width, -0.5 * depth, 0])
			rotate(v = [1, 0, 0], a = -7)
				translate(v = [0, -depth, 0])
					cube(size = [2 * base_width, depth, 2 * height]);
		translate(v = [1.0 * base_width, depth, 0.6 * height])
			rotate(v = [1, 0, 0], a = 90)
				scale(v = [0.6, 1.0, 1.0])
					cylinder(r1 = 0.5 * height, r2 = 0.5 * height, h = 2 * depth);
	}
}

module snap_arm(scale_factor)
{
	scale(v = [0.01 * scale_factor, 0.01 * scale_factor, 0.01 * scale_factor]) {
		union() {
			tapered_cantilever_snap_arm_base(25, 50, 100);
			translate(v = [0, 0, 100])
				cantilever_snap_head(15, 25);
		}
	}
}
/*
module fader_snap_arm()
{
	snap_arm(11);
}

module fader_snap_arms(count)
{
	fader_snap_arm();
	translate(v = [88, 0, 0])
			rotate(v = [0, 0, 1], a = 180)
				fader_snap_arm();

	for (i = [1 : 1 : count]) {
		translate(v = [i * 88/(count + 1), -6, 0])
			rotate(v = [0, 0, 1], 90)
				fader_snap_arm();
		translate(v = [i * 88/(count + 1), 6, 0])
			rotate(v = [0, 0, 1], -90)
				fader_snap_arm();
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
*/

/* tapered_cantilever_snap_arm(8, 11, 1.2, 6, 10, 15); */
/* fader_snap_arms(3); */
/* tapered_snap_arm_row(3, 6.6, 1.2, 7, 10, 15, 6, 100); */
