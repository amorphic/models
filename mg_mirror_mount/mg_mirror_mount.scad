body_length = 83.3;
body_width = 39.5;
body_height = 25;
body_curve_gap = 2;
bracket_inner_length = 45.3;
bracket_inner_width = 20.5;
hole_diameter = 5.1;
hole_one_offset_x = -6.7;
hole_one_offset_y = -1.5;
hole_two_offset_x = 14.2;
hole_two_offset_y = 1.5;
hole_y_multiplier = -1;

module holes(){
    translate([hole_one_offset_x,hole_one_offset_y*hole_y_multiplier,-body_height/2]){
        cylinder(d=hole_diameter, h=body_height+body_curve_gap, $fn=180, center=true);
    }
    translate([hole_two_offset_x,hole_two_offset_y*hole_y_multiplier,-body_height/2]){
        cylinder(d=hole_diameter, h=body_height+body_curve_gap, $fn=180, center=true);
    }
}

module bracket(){
    translate([0,0,body_curve_gap/2]){
        union(){
            cube([bracket_inner_length,bracket_inner_width, body_curve_gap], center=true);
            translate([bracket_inner_length/2,0,0]){
                cylinder(d=bracket_inner_width, h=body_curve_gap, $fn=180, center=true);
            }
            translate([-bracket_inner_length/2,0,0]){
                cylinder(d=bracket_inner_width, h=body_curve_gap, $fn=180, center=true);
            }
        }
    }
}

module body_top(){
    intersection(){
        rotate([90,0,0]){
            scale([body_length,body_curve_gap*2,1]){
                    cylinder(d=1, h=body_width, $fn=180, center=true);
            }
        }
        scale([body_length,body_width,1]){
            cylinder(d=1, h=body_curve_gap, $fn=180);
        }
    }
}

module body_bottom(){
    scale([body_length,body_width,1]){
        cylinder(d=1, h=body_height, $fn=180);
    }
}

module body(){
    difference(){
        union(){
            body_top();
            translate([0,0,-body_height]){
                body_bottom();
            }
        }
        bracket();
        holes();
    }
}

body();
//bracket();
//holes();