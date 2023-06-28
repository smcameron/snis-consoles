/*
  3d printable insert for warp and impulse faders on Navigation control panel
*/

plate_thickness = 3;
countersink = 0.01;
fader_spacing = 40;
fader_count = 2;
web_thickness = 3;
web_height = 10;
tang_hole_width = 2;
plate_height = 110;

include <fader-insert-60mm-array.scad>

fader_60mm_array_insert(0, 0, fader_spacing, fader_count);
