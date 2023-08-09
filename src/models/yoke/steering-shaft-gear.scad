
// This include file is from:
// git@github.com:brhubbar/meshing-gears-OpenSCAD.git
include <../../../../meshing-gears-OpenSCAD/src/meshing_gears.scad>

$fn=100;

//  herringbone_gear(pitch_diameter,
//                    bore_diameter,
//                    helix_angle,
//                    thickness,
//                    pressure_angle,
//                    diametral_pitch
//                    )

module steering_shaft_gear()
{
	union() {
		herringbone_gear(pitch_diameter = 36, bore_diameter = 22.5);
		translate(v = [0, 0, 10])
		difference() {
			cylinder(h = 15, r1 = 0.5 * 26, r2 = 0.5 * 26, center = true);
			cylinder(h = 35, r1 = 0.5 * 22.5, r2 = 0.5 * 22.5, center = true);
			translate(v = [0, 20, 2])
			rotate(v = [1, 0, 0], a = 90)
				cylinder(h = 40, r1 = 2, r2 = 2);
		}
	}
}

module steering_potentiometer_gear()
{
	herringbone_gear(pitch_diameter = 24, bore_diameter = 6);
}

steering_shaft_gear();
translate(v = [40, 0, 0])
	steering_potentiometer_gear();




