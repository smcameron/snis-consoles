/* using library from : git@github.com:smcameron/Rack-Pinion-openscadLib.git */

include <../../../../Rack-Pinion-openscadLib/RackPinionLibRedesign.scad>

// module rack(cp, N, width, thickness, lip=0){
// cp = circular pitch - for rack = pitch in mm/per tooth
// N = number of teeth
// width = width of rack
// thickness = thickness of support under teeth (0 for no support)
// lip = how thick of a radius the goove and nub are


/* 
 * 3mm per tooth
 * 49 teeth, = 147 mm rack length
 * 10mm wide
 * 5mm backing material
 *
 */
rack(3, 49, 10, 5, lip=0);



