length = 40;
bracket_width = 24;
bracket_height = 20;
bracket_hole_offset = 10;
bracket_hole_depth = 16;
bracket_hole_screw_diameter = 4;
bracket_hole_diameter = 8;
main_width = 44;
main_height = 14;
wall_thickness = 2;
lid_thickness = 1.2;
switch_length = 15.8;
switch_width = 27.8;
switch_height = 9.8;
switch_hole_diameter = 3.1;
switch_hole_offset = 1.2;
switch_peg_diameter = switch_hole_diameter - .2;
switch_peg_height = switch_height;
switch_terminal_offset = 14.1;
cable_hole_diameter = 10;
cable_hole_offset = 12;

module switch_peg(){
    cylinder(d=switch_peg_diameter, h=switch_peg_height, center=false, $fn=180);
}

module main(){
    // switch pegs
    translate([main_width - wall_thickness - (switch_peg_diameter / 2) - switch_hole_offset, length - switch_length+ switch_hole_offset + (switch_peg_diameter / 2), wall_thickness]) {
        switch_peg();
    }
    translate([main_width - wall_thickness - switch_width + (switch_peg_diameter / 2) + switch_hole_offset, length - switch_hole_offset - (switch_peg_diameter / 2), wall_thickness]) {
        switch_peg();
    }  
    // box
    difference() {
        cube([main_width, length, main_height], center=false);
        translate([wall_thickness, 2.0, wall_thickness]){
            cube([main_width - (wall_thickness * 2), length, main_height - (wall_thickness)], center=false);
        }
        // cable hole
        translate([0.0, length - cable_hole_offset, main_height / 2]){
            rotate([0,90,0]){
                cylinder(d=cable_hole_diameter, h=wall_thickness, center=false, $fn=180);
            }
        }
    }
}

module bracket_screw_hole(){
    union(){
        rotate([0,90,0]){
            cylinder(d=bracket_hole_diameter, h=bracket_hole_depth, center=false, $fn=180);
        }
        rotate([0,90,0]){
            cylinder(d=bracket_hole_screw_diameter, h=bracket_width, center=false, $fn=180);
        }
    }
}

module bracket(){
    translate([0.0, 0.0, -bracket_height]){
        difference(){
            cube([bracket_width, length, bracket_height], center=false);
            translate([0.0, length - bracket_hole_offset, bracket_height / 2]){
                bracket_screw_hole();
            }
            translate([0.0, bracket_hole_offset, bracket_height / 2]){
                bracket_screw_hole();
            }
        }
    }
}

module lid(){
    union(){
        cube([main_width, length, wall_thickness], center=false);
        translate([wall_thickness, wall_thickness, wall_thickness]){
            cube([main_width - wall_thickness * 2, length - wall_thickness * 2, lid_thickness], center=false);
        }
    }
}

module enclosure(){
    union(){
        main();
        bracket();
    }
}

enclosure();
//lid();