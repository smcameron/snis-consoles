
mm = 25.4; /* mm / inch */
pi = 3.1415927;

lower_panel_angle = 15.0; /* degrees */
upper_panel_angle = 70.0; /* degrees */
base_depth = 14.0; /* inches */

x1 = 0 * mm;
y1 = 0 * mm;

x2 = base_depth * mm;
y2 = 0 * mm;

x3 = x2 + 1/tan(75.0) * mm;
y3 = 1 * mm;

x4 = x3 - (7.0 * cos(lower_panel_angle)) * mm;
y4 = y3 + (7.0 * sin(lower_panel_angle)) * mm;

x5 = x4 - (8.5 * cos(upper_panel_angle)) * mm;
y5 = y4 + (8.5 * sin(upper_panel_angle)) * mm;

x6 = 0;
y6 = y5;

echo("x1, y1 = ", x1, y1);
echo("x2, y2 = ", x2, y2);
echo("x3, y3 = ", x3, y3);
echo("x4, y4 = ", x4, y4);
echo("x5, y5 = ", x5, y5);
echo("x6, y6 = ", x6, y6);

polygon(points = [
		[x1, y1],
		[x2, y2],
		[x3, y3],
		[x4, y4],
		[x5, y5],
		[x6, y6]]);


