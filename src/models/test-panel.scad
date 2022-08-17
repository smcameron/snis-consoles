
use <fader-60mm-holes.scad>
use <potentiometer-hole.scad>
use <switch-hole.scad>
use <toggle-switch-hole.scad>

module panel_holes()
{
	fader_array(0, 0, 18, 2);
	switch_hole(0, 40);
	switch_hole(0, 63);
	switch_hole(35, 40);
	switch_hole(35, 63);
	toggle_switch_hole(0, -30);
	toggle_switch_hole(40, -30);
	potentiometer_hole(80, 40);
	potentiometer_hole(80, 0);
}

module panel_outline()
{
	translate(v = [0, 0, 0])
	square(size = [220, 150], center = true);
}

translate(v = [100, 100, 0]) {
	panel_holes();
	/* panel_outline(); */
}

