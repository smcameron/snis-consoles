$fn = 100;

module needle_arm_rot(angle)
{
	rotate(v = [0, 0, 1], a = angle)
	union() {
		cylinder(r1 = 4, r2 = 4, h = 5);
		translate(v = [-2.5, -13, 0])
			cube(size = [5, 46, 3]);
	}
}

module needle_arm()
{
	intersection() {
		needle_arm_rot(-2.5);
		needle_arm_rot(2.5);
	}
}

module needle_hub()
{
	difference() {
		needle_arm();
		translate(v = [0, 0, 2])
			cylinder(r1 = 2.5, r2 = 2.5, h = 5);
	}
}


needle_hub();
