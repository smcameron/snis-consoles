
include <cantilever-snap.scad>

tapered_cantilever_snap_arm(8, 11, 1.2, 6, 10, 15);
translate(v = [0, 50, 0])
	fader_snap_arms(3);
translate(v = [0, -50, 0])
	tapered_snap_arm_row(3, 6.6, 1.2, 7, 10, 15, 6, 100);

