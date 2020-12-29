rail_width = 50;
rail_height = 20;
rail_tolerance = 0.5;
wall_thickness = 3;
box_length = 60;
box_height = 42;
button_hole_diameter = 22;
screw_hole_diameter = 4;
screw_hole_offset = 12;
cable_hole_diameter = 4;
cable_hole_offset = 4;

module box_outer(){
    cube([
        box_length,
        rail_width + wall_thickness * 2 + rail_tolerance * 2,
        box_height + rail_height
    ]);
}

module rail_cutout(){
    translate([0, wall_thickness, 0]){
        cube([
            box_length,
            rail_width + rail_tolerance * 2,
            rail_height,
        ]);
    }
}

module box_inner_cutout(){
    translate([wall_thickness, wall_thickness, rail_height + wall_thickness]){
        cube([box_length - wall_thickness * 2, rail_width, box_height - wall_thickness]);
    }
}

module button_hole_cutout(){
    translate([0, rail_width / 2 + wall_thickness + rail_tolerance, rail_height + box_height / 2]){
        rotate([0, 90, 0]){
            cylinder(d=button_hole_diameter, h=wall_thickness, center=false, $fn=180);
        }
    }
}

module screw_hole(){
    translate([0, wall_thickness, 0]){
        rotate([90, 0, 0]){
            cylinder(d=screw_hole_diameter, h=wall_thickness + rail_tolerance, center=false, $fn=60);
        }
    }
}

module cable_hole(){
    translate([box_length - wall_thickness - cable_hole_offset - cable_hole_diameter * 2, 0, rail_height + wall_thickness + cable_hole_offset]){
        hull(){
            translate([0, wall_thickness, 0]){
                rotate([90, 0, 0]){
                    cylinder(d=screw_hole_diameter, h=wall_thickness + rail_tolerance, center=false, $fn=60);
                }
            }
            translate([cable_hole_diameter, wall_thickness, 0]){
                rotate([90, 0, 0]){
                    cylinder(d=screw_hole_diameter, h=wall_thickness + rail_tolerance, center=false, $fn=60);
                }
            }
        }
    }
}

module screw_holes(){
    translate([screw_hole_offset, 0, rail_height / 2]){
        screw_hole();
    }
    translate([box_length - screw_hole_offset, 0, rail_height / 2]){
        screw_hole();
    }
    translate([screw_hole_offset, rail_width + wall_thickness + rail_tolerance * 2, rail_height / 2]){
        screw_hole();
    }
    translate([box_length - screw_hole_offset, rail_width + wall_thickness + rail_tolerance * 2, rail_height / 2]){
        screw_hole();
    }
}

module main(){
    difference(){
        box_outer();
        box_inner_cutout();
        rail_cutout();
        button_hole_cutout();
        screw_holes();
        cable_hole();
    }
}

main();