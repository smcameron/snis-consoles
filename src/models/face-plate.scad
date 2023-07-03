
module truncated_hemisphere(thickness)
{
	r = 2 * thickness;
	difference() {
		sphere(r);
		translate(v = [0, 0, -r])
			cube(size = [2 * r, 2 * r, 2 * r], center = true);
		translate(v = [0, 0, 3 * thickness])
			cube(size = [2 * r, 2 * r, 2 * r], center = true);
	}
}

module face_plate(width, height, thickness)
{
	r = thickness;
	hull() {
		translate(v = [r, 0, 0])
			truncated_hemisphere(r);
		translate(v = [width - r, r, 0])
			truncated_hemisphere(r);
		translate(v = [width - r, height - r, 0])
			truncated_hemisphere(r);
		translate(v = [r, height - r, 0])
			truncated_hemisphere(r);
	}
}

