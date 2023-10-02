/*

Width x height measurements for holes to be cut in the nav panels:

5x2 button array: 72mm by 127mm
1x5 button array: 177x27mm
2x2 button array: 72x52mm
Steering column shroud: 37x95mm
Warp/Impulse controls: 76x103mm
zoom pot: 42x47mm

gauge hole diameter: 80mm

speakers: 102x46mm

Monitor: 21.5 inches == 546.1mm

keyboard: 155x65

*/

panel_width = 570;
panel_height = 200;

module upper_panel_outline()
{
	square(size = [panel_width, panel_height], center = true);
}

module fivextwo_button_array()
{
	square(size = [72, 127], center = true);
}

module twoxtwo_button_array()
{
	square(size = [72, 52], center = true);
}

module onexfive_button_array()
{
	square(size = [177, 27], center = true);
}

module gauge_hole()
{
	circle(d = 80);
}

module zoom_pot_hole()
{
	square(size = [42, 47], center = true);
}

module speaker_hole()
{
	square(size = [46, 102], center = true);
}

module upper_panel()
{
	difference() {
		upper_panel_outline();
		translate(v = [220, 0, 0])
			fivextwo_button_array();
		translate(v = [-220, -50, 0])
			twoxtwo_button_array();
		translate(v = [0, -50, 0])
			onexfive_button_array();
		translate(v = [-50, 30, 0])
			gauge_hole();
		translate(v = [50, 30, 0])
			gauge_hole();
		translate(v = [-220, 50, 0])
			zoom_pot_hole();
		translate(v = [-135, 0, 0])
			speaker_hole();
		translate(v = [135, 0, 0])
			speaker_hole();
	}
}

upper_panel();
