
include <cantilever-snap.scad>

fader_snap_arms(4);

difference() {
	translate(v = [-3, -10, -3.5])
		cube(size = [95, 20, 3.5]);
	translate(v = [3, -1.5, -6])
		cube(size = [83, 3, 15]);
}

