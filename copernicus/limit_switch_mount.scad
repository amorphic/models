length = 63;
spacer_width = 24;
spacer_height = 20;
spacer_hole_offset = 14;
spacer_mount_overlap = 12;
spacer_hole_depth = 16;
spacer_hole_screw_diameter = 4;
spacer_hole_diameter = 8;
mount_width = 28;
mount_height = 7;
mount_hole_offset = 3.5;
mount_hole_screw_diameter = 4.5;

module spacer_screw_hole() {
    translate([spacer_width + spacer_mount_overlap, 0, 0]){
        rotate([0, 270, 0]) {
            union() {    
                cylinder(d=spacer_hole_diameter, h=spacer_hole_depth, center=false, $fn=180);
                cylinder(d=spacer_hole_screw_diameter, h=spacer_width + spacer_mount_overlap, center=false, $fn=180);
            }
        }
    }
}

module spacer() {
    difference() {
        cube([spacer_width + spacer_mount_overlap, length, spacer_height]);
        translate([0, spacer_hole_offset, spacer_height / 2]) {
            spacer_screw_hole();
        }
        translate([0, length - spacer_hole_offset, spacer_height / 2]) {
            spacer_screw_hole();
        }
    }
}

module mount_screw_hole() {
    cylinder(d=mount_hole_screw_diameter, h=mount_height, center=false, $fn=180);
}

module mount() {
    union() {
        cube([spacer_mount_overlap, length, mount_height]);
        translate([spacer_mount_overlap, 0, 0]) {
            difference() {
                cube([mount_width, length, mount_height]);
                translate([mount_hole_offset, mount_hole_offset,]){
                    mount_screw_hole();
                }
                translate([mount_width - mount_hole_offset, mount_hole_offset,]){
                    mount_screw_hole();
                }
                translate([mount_hole_offset, length - mount_hole_offset,]){
                    mount_screw_hole();
                }
                translate([mount_width - mount_hole_offset, length - mount_hole_offset,]){
                    mount_screw_hole();
                }
            }
        }
    }
}

module main() {    
    union() {
        spacer();
        translate ([spacer_width, 0, -mount_height]) {
            mount();
        }
    }
}

main();