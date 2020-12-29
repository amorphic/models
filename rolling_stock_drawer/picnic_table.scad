thickness = 12;
cutout_tolerance = .1;
top_edge = 380;
top_radius = 48;
base_span_height = 40;
base_span_radius = 24;
base_stem_height = 40;
base_stem_width = 160;
$fn=120;

module base_span(x,y,z,r){
    translate([-x/2,-y/2,0]){
        hull(){
            translate([r/2,r/2,0]) cube([r,r,z], true);
            translate([-(r/2)+x,r/2,0]) cube([r,r,z], true);
            translate([(r/2),-(r/2)+y,-z/2]) cylinder(h=z,d=r);
            translate([-(r/2)+x,-(r/2)+y,-z/2]) cylinder(h=z,d=r);
        }
    }
}

module base_section(length, span_height, stem_height, stem_width, thickness, radius, tolerance, bottom_notch, top_notch, tab_extra_height){ 
    tab_fraction = 20;
    tab_length = length / tab_fraction;
    notch_height = (span_height * 2 + stem_height) / 2;
    
    difference() {
        translate([0, -(span_height / 2 + stem_height / 2), 0]){
            union(){
                // bottom
                base_span(length, span_height, thickness, radius);
                // stem
                translate([0, span_height / 2 + stem_height / 2, 0]) {
                    cube([stem_width, stem_height, thickness], true);
                }
                // top
                translate([0, span_height / 2 + stem_height + span_height / 2, 0]){
                    mirror([0,1,0]){
                        base_span(length, span_height, thickness, radius);
                    }
                }
                // tab 1
                translate([-length / 2 + tab_length, span_height / 2 + stem_height + span_height + thickness / 2, 0]){
                    cube([tab_length + tolerance, thickness + tab_extra_height, thickness + tolerance], true); 
                }
                // tab 2
                translate([length / 2 - tab_length, span_height / 2 + stem_height + span_height + thickness / 2, 0]){
                    cube([tab_length + tolerance, thickness + tab_extra_height, thickness + tolerance], true);
                }
            }
        }
        // bottom notch
        if (bottom_notch) {
            translate([0, -notch_height / 2, 0]) {
                cube([thickness + tolerance, notch_height, thickness], true);
            }
        }
        // top notch
        if (top_notch) {
            translate([0, notch_height / 2, 0]) {
                cube([thickness + tolerance, notch_height, thickness], true);
            }
        }
    }
}

module top(x,y,z,r){
    translate([-x/2,-y/2,0]){
        hull(){
            translate([r/2,r/2,-z/2]) cylinder(h=z,d=r);
            translate([-(r/2)+x,r/2,-z/2]) cylinder(h=z,d=r);
            translate([(r/2),-(r/2)+y,-z/2]) cylinder(h=z,d=r);
            translate([-(r/2)+x,-(r/2)+y,-z/2]) cylinder(h=z,d=r);
        }
    }
}

module base_assembly(base_edge, base_span_height, base_stem_height, base_stem_width, thickness, base_span_radius, tolerance, tab_extra_height){
    translate([0,0,-(base_span_height + base_stem_height / 2)]){
        union(){
            rotate([90,0,45]){
                base_section(top_edge, base_span_height, base_stem_height, base_stem_width, thickness, base_span_radius, cutout_tolerance, false, true, tab_extra_height);
            }
            rotate([90,0,-45]){
                base_section(top_edge, base_span_height, base_stem_height, base_stem_width, thickness, base_span_radius, cutout_tolerance, false, true, tab_extra_height);
            }
        }
    }
}

module top_assembly(){
    translate([0, 0, thickness / 2]) {
        top(top_edge, top_edge, thickness, top_radius);
    }
}

module table_assembly(){
    color("red"){
        top_assembly(top_edge, top_edge, thickness, top_radius);
    }
    color("olive"){
        base_assembly(top_edge, base_span_height, base_stem_height, base_stem_width, thickness, base_span_radius, 0, 0.01);
    }
}

module top_output(){
    difference(){
        translate([0, 0, thickness / 2]) {
            top(top_edge, top_edge, thickness, top_radius);
        }
        translate([0, 0, -0.1]) {
            base_assembly(top_edge, base_span_height, base_stem_height, base_stem_width, thickness, base_span_radius, cutout_tolerance, 0.3);
        }
    }
}

module base_upper_output(){
    base_section(top_edge, base_span_height, base_stem_height, base_stem_width, thickness, base_span_radius, cutout_tolerance, true, false, 0);
}

module base_lower_output(){
    base_section(top_edge, base_span_height, base_stem_height, base_stem_width, thickness, base_span_radius, cutout_tolerance, false, true, 0);
}

table_assembly();
//top_output();
//base_upper_output();
//base_lower_output();
