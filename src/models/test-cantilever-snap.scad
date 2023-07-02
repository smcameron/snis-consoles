
include <cantilever-snap.scad>

translate(v = [0, -75, 0])
	cantilever_snap_head(10, 10);

translate(v= [0, -100, 0])
	cantilever_snap_arm_base(10, 20, 40);

translate(v= [0, -150, 0])
	tapered_cantilever_snap_arm_base(10, 20, 40);

translate(v= [0, -200, 0])
	snap_arm(100);
