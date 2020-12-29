include <prism.scad>

rail_width = 50;
rail_height = 20;
rail_length = 120;
rail_tolerance = 0.5;
wall_thickness = 3;
box_width = 58;
box_length = 66;
box_height = 42;
button_hole_diameter = 22;
screw_hole_diameter = 4;
screw_hole_offset = 12;
cable_hole_diameter = 4;
cable_hole_offset = 4;
lid_tolerance = 0.2;
box_bracket_overlap = 25;
bracket_rail_overlap = 25;
large_screw_hole_depth = 12;
large_screw_head_diameter = 8;
large_screw_shaft_diameter = 4;
large_screw_hole_offset = 16;

module bracket(){
    difference(){
        cube([
            box_length + bracket_rail_overlap,
            box_width,
            rail_height + wall_thickness
        ]);
        translate([box_length + bracket_rail_overlap, 0, 0]){
           rotate([0, 0, 90]){
                prism(
                    box_length + bracket_rail_overlap,
                    box_width - box_bracket_overlap - wall_thickness,
                    rail_height
                );
            }
        }
        translate([
            large_screw_hole_offset,
            0,
            (rail_height + wall_thickness) / 2]
        ){
            large_screw_hole();
        }
        translate([
            box_length + bracket_rail_overlap - large_screw_hole_offset,
            0,
            (rail_height + wall_thickness) / 2]
        ){
            large_screw_hole();
        }
        translate([
            box_length + bracket_rail_overlap - bracket_rail_overlap / 2,
            box_width - box_bracket_overlap,
            rail_height]
        ){
            small_screw_hole();
        }
    }    
}

module small_screw_hole(){
    rotate([0, 0, 0]){
            cylinder(d=screw_hole_diameter, h=wall_thickness, center=false, $fn=60);
    }
}

module large_screw_hole() {
    rotate([270, 0 ,0]){
        union() {    
            cylinder(d=large_screw_shaft_diameter, h=box_width, center=false, $fn=60);
            cylinder(d=large_screw_head_diameter, h=box_bracket_overlap - wall_thickness, center=false, $fn=180);
        }
    }
}

module box_outer(){
    cube([
        box_length,
        box_width,
        box_height
    ]);
}

module box_inner_cutout(){
    translate([wall_thickness, wall_thickness, wall_thickness]){
        cube([
            box_length - wall_thickness * 2,
            box_width - wall_thickness * 2,
            box_height - wall_thickness * 2
        ]);
    }
}

module button_hole_cutout(){
    translate([0, box_width / 2, box_height / 2]){
        rotate([0, 90, 0]){
            cylinder(d=button_hole_diameter, h=wall_thickness, center=false, $fn=180);
        }
    }
}

module cable_hole_cutout(){
    translate([box_length - wall_thickness - cable_hole_offset - cable_hole_diameter * 2, 0, wall_thickness + cable_hole_offset + cable_hole_diameter / 2]){
        hull(){
            translate([0, wall_thickness, 0]){
                rotate([90, 0, 0]){
                    cylinder(d=cable_hole_diameter, h=wall_thickness + rail_tolerance, center=false, $fn=60);
                }
            }
            translate([cable_hole_diameter, wall_thickness, 0]){
                rotate([90, 0, 0]){
                    cylinder(d=cable_hole_diameter, h=wall_thickness + rail_tolerance, center=false, $fn=60);
                }
            }
        }
    }
}

module lid(){
    color("green"){
        translate([0, 0, box_height - wall_thickness]){
            union(){
                translate([0, 0, wall_thickness]){
                    cube([
                        box_length,
                        box_width,
                        wall_thickness
                    ]);
                }
                translate([wall_thickness, wall_thickness, 0]){
                    cube([
                        box_length - wall_thickness * 2,
                        box_width - wall_thickness * 2,
                        wall_thickness
                    ]);
                }
            }
        }
    }
}

module rail(){
    color("white"){
        cube([
            rail_length,
            rail_width,
            rail_height,
        ]);
    }
}

module box(){
    difference(){
        box_outer();
        box_inner_cutout();
        button_hole_cutout();
        lid();
        cable_hole_cutout();
    }
}

module main() {
    difference() {
        union(){
            translate([0, -box_width + box_bracket_overlap, rail_height]){
                box();            
            }
            translate([0, -box_width + box_bracket_overlap, 0]){
                bracket();
            }
        }
        rail();
    }
}

module assembly() {
    translate([10, 0, 0]){
        main();
        translate([0, -box_width + box_bracket_overlap, rail_height]){        
            lid();
        }
    }
}        

//bracket();
//main();
lid();
//assembly();
//rail();
