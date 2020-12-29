thickness = 12;
top_edge = 380;
top_radius = 48;
base_edge = sqrt(top_edge * top_edge * 2);
base_span_height = 60;
base_span_radius = 36;
base_stem_height = 40;
base_stem_width = 160;
$fn=120;

module top(x,y,z,r){
    hull(){
        translate([r/2,r/2,-z/2]) cylinder(h=z,d=r);
        translate([-(r/2)+x,r/2,-z/2]) cylinder(h=z,d=r);
        translate([(r/2),-(r/2)+y,0]) cylinder(h=z,d=r);
        translate([-(r/2)+x,-(r/2)+y,0]) cylinder(h=z,d=r);
    }
}

module base_span(x,y,z,r){
    hull(){
        translate([r/2,r/2,0]) cube([r,r,z], true);
        translate([-(r/2)+x,r/2,0]) cube([r,r,z], true);
        translate([(r/2),-(r/2)+y,-z/2]) cylinder(h=z,d=r);
        translate([-(r/2)+x,-(r/2)+y,-z/2]) cylinder(h=z,d=r);
    }
}

module base_section(length, span_height, stem_height, stem_width, thickness, radius){ 
    union() {
        base_span(length, span_height, thickness, radius);
        translate([0, (span_height * 2 + stem_height), 0]) {
            mirror([0,1,0]){
                base_span(length, span_height, thickness, radius);
            }
        }
        translate([length / 2, span_height + stem_height / 2, 0]) {
            cube([stem_width, stem_height, thickness], true);
        }
        cube([length / 16, thickness, thickness], true);
    }
}

module base(base_edge, base_span_height, base_stem_height, base_stem_width, thickness, base_span_radius) {
    // section 1
        difference() {
        base_section(base_edge, base_span_height, base_stem_height, base_stem_width, thickness, base_span_radius);
        translate([base_edge / 2 - thickness / 2, base_span_height + base_stem_height / 2, -thickness / 2]) {
            cube([thickness, base_span_height + base_stem_height / 2, thickness]);
        }
    }/*
    // section 2
    difference() {
        base_section(base_edge, base_span_height, base_stem_height, base_stem_width, thickness, base_span_radius);
        translate([base_edge / 2 - thickness / 2, 0, -thickness / 2]) {
            cube([thickness, base_span_height + base_stem_height / 2, thickness]);
        }
    }*/
}

//top(top_edge, top_edge, thickness, top_radius);
base(base_edge, base_span_height, base_stem_height, base_stem_width, thickness, base_span_radius);