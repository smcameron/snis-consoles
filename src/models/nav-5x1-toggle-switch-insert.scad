/*
  3d printable insert for toggle switches for the Navigation control panel  
*/

plate_thickness = 3;
countersink = 0.01;
pot_horizontal_spacing = 40;
pot_vertical_spacing = 40;
pot_cols = 5;
pot_rows = 1;
hole_radius = 12; /* mm */
plate_horizontal_border = 15;
plate_vertical_border = 20;
plate_height = pot_rows * pot_vertical_spacing + 2 * plate_vertical_border;
plate_width =  pot_cols * pot_horizontal_spacing + 2 * plate_horizontal_border;
screw_radius = 0.5 * 4; 
screw_edge_offset = 5;

web_thickness = 4;
web_height = 8;
web_edge_offset = screw_edge_offset + screw_radius;
web_screw_offset = 2 * web_edge_offset;
web_horiz_len = plate_width - 2 * web_screw_offset;
web_vert_len = plate_height - 2 * web_screw_offset;

include <potentiometer-insert.scad>

pot_array_plate();

