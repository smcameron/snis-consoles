
kerf=0.21;
width = 30 - 0.4;
height = 20 - 0.4;
spacing = 3;

rows = 1;
cols = 1;
material_width = 2.54 * 10 * 10; /* 10 inches */
material_height = 2.54 * 8 * 10; /* 8 inches */

echo("Rows = ", rows, "Cols = ", cols);
echo("Max rows = ", material_height / (height + spacing + kerf));
echo("Max cols = ", material_width / (width + spacing + kerf));

for (r = [0 : 1 : rows - 1]) {
	translate(v = [0, r * (height + spacing + kerf)]) {
		for (c = [0 : 1 : cols - 1]) {
			translate(v = [c * (width + spacing + kerf), 0]) {
				square(size = [width + kerf, height + kerf]);
			}
		}
	}
}

