bracket_length = 353;
bracket_height = 44;
gap_length = 240;
gap_height = 20;
side_length = (bracket_length - gap_length) / 2;
$fn=50;
curve_radius = 16;


module side(x,y,r){
    hull(){
        z=1;
        translate([r/2,r/2,0]) cube([r,r,z], true);
        translate([-(r/2)+x,r/2,0]) cube([r,r,z], true);
        translate([(r/2),-(r/2)+y,0]) cube([r,r,z], true);
        translate([-(r/2)+x,-(r/2)+y,-z/2]) cylinder(h=z,d=r);
    }
}

module cutout(x,y,r){
    hull(){
        z=2;
        translate([r/2,r/2,-z/2]) cylinder(h=z,d=r);
        translate([-(r/2)+x,r/2,-z/2]) cylinder(h=z,d=r);
        translate([(r/2),-(r/2)+y,0]) cube([r,r,z], true);
        translate([-(r/2)+x,-(r/2)+y,0]) cube([r,r,z], true);
    }
}

projection() {
    difference() {
        union() {
            // left side
            side(side_length, bracket_height, curve_radius);
            // right side
            translate([bracket_length,0,0]){
                mirror([1,0,0]) {
                    side(side_length, bracket_height, curve_radius);
                }
            }
            // middle
            cube([bracket_length, bracket_height-gap_height+(curve_radius/4),1]);
        }
        translate([(bracket_length - gap_length) / 2,bracket_height - gap_height - (curve_radius/4),0]){
            cutout(gap_length, bracket_height - gap_height + curve_radius, curve_radius);
        }
    }
}