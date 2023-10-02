panel_width = 570;
panel_height = 200;

steering_column_width = 37;
steering_column_height = 95;

warp_impulse_width = 76;
warp_impulse_height = 103;

keyboard_width = 155;
keyboard_height = 65;


module lower_panel_outline()
{
	square(size = [panel_width, panel_height], center = true);
}

module steering_column_shroud_hole()
{
	square(size = [steering_column_width, steering_column_height], center = true);
}

module warp_impulse_hole()
{
	square(size = [warp_impulse_width, warp_impulse_height], center = true);
}

module keyboard_hole()
{
	square(size = [keyboard_width, keyboard_height], center = true);
}

module lower_panel()
{
	difference() {
		lower_panel_outline();
		steering_column_shroud_hole();
		translate(v = [-220, 0, 0])
			warp_impulse_hole();
		translate(v = [190, -50, 0])
			keyboard_hole();
	}
}

lower_panel();
