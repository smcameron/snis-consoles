/* using library from : git@github.com:smcameron/Rack-Pinion-openscadLib.git */

include <../../../../Rack-Pinion-openscadLib/RackPinionLibRedesign.scad>

// module pinion (cp, N, width, shaft_diameter, backlash=0){
// cp= circular pitch - for pinion pitch in mm/per as measured along the ptich radius (~1/2 way up tooth)
// N= number of teeth
// width= width of the gear
// shaft_diameter= diameter of hole for shaft
// backlash - I think this is just a bodge for making things fit when printed but I never tested it


/* 
 * 3mm per tooth
 * 65 teeth, = 147*4/3 mm rack length
 * 10mm wide
 * 5mm backing material
 *
 */
pinion(3, 65, 10, 6.0);



