shaft_radius = 11;
shaft_tolerance = 0.75;
cage_height = 40;
cage_width = 75;
cage_length = 170;
block_thickness = 8;

module fixup_fillet()
{
	rotate(v = [1, 0, 0], a = 40)
		cube(size = [cage_length - 20, block_thickness - 6, 5]);
}

module cage_side()
{
	union() {
	difference() {
		cube(size = [cage_length, block_thickness, cage_height + 5]);
		translate(v = [10, 6.1, 5])
			cube(size = [cage_length - 20, block_thickness - 6, cage_height + 5 - 10]);
		translate(v = [10, -0.1, 5])
			cube(size = [cage_length - 20, block_thickness - 6, cage_height + 5 - 10]);
	}
	translate(v = [10, 3.1, cage_height - 3])
		fixup_fillet();
	translate(v = [10, 6.5, cage_height - 3 + 5]) 
		mirror(v = [0, 0, 1])
			fixup_fillet();
	}
}

module cage_end_basic()
{
	cube(size = [block_thickness, cage_width, cage_height]);
}

module yoke_cage_basic()
{
	cage_side();
	cage_end_basic();
	translate(v = [0, cage_width - block_thickness, 0])
		cage_side();
	translate(v = [cage_length - block_thickness, 0])
		cage_end_basic();
}

module yoke_cage()
{
	difference() {
		yoke_cage_basic();
		translate(v = [-cage_length / 4, cage_width / 2, cage_height / 2])
			rotate(v = [0, 1, 0], a = 90)
				cylinder(r1 = shaft_radius + shaft_tolerance, r2 = shaft_radius + shaft_tolerance, h = 1.5 * cage_length);
	}
}

yoke_cage();

