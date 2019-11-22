// Parameters
bracket_length = 234;
bracket_width = 48.5;
bracket_height = 3;
slot_width = 8;
slot_height = 12;
notch_width = 3.1;
notch_height = 5;
cutout_count = 6;
cutout_radius = 5;

cutout_length = (bracket_length - (slot_width * cutout_count)) / cutout_count;

module cutout() {    
    translate([(cutout_length/2), bracket_width/2, (slot_height/2 + cutout_radius + bracket_height)]) {
        rotate([90, 0, 0]) {
            minkowski() {
                cube([cutout_length-(cutout_radius*2), slot_height, bracket_width/2], center=true);
                cylinder(r=cutout_radius, h=bracket_width/2, center=true, $fn=180);
            }
        }
    }
}

module cutouts() {
    for (x=[slot_width/2:cutout_length+slot_width:(bracket_length-slot_width)]) {
        translate([x, 0, 0]) {
            cutout();
        }
    }
}

module notch() {    
    translate([-notch_width/2, 0, bracket_height+slot_height-notch_height]) {
        cube([notch_width, bracket_width, notch_height]);
    }
}

module notches() {
    notch_gap = cutout_length+slot_width;
    for (x=[notch_gap:notch_gap:bracket_length-notch_gap]) {
        translate([x, 0, 0]) {
            notch();
        }
    }
}

module bracket() {
    difference() {
        cube([bracket_length, bracket_width, (bracket_height + slot_height)]);
        cutouts();
        notches();
    }
}

bracket();