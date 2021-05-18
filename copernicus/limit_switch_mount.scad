include <prism.scad>

length = 63;
spacer_width = 27;
spacer_height = 20;
spacer_mount_overlap_width = 8;
spacer_mount_overlap_height = 8;
spacer_hole_offset = 12;
spacer_hole_depth = 16;
spacer_hole_screw_diameter = 4;
spacer_hole_diameter = 8;
spacer_hole_cutoff_width = 12;
spacer_hole_cutoff_height = 12;
mount_width = 28;
mount_height = 7;
mount_hole_offset = 3.5;
mount_hole_screw_diameter = 4.5;
text_depth = 1;

module spacer_screw_hole() {
    translate([spacer_width + spacer_mount_overlap_width, 0, 0]){
        rotate([0, 270, 0]) {
            union() {    
                cylinder(d=spacer_hole_diameter, h=spacer_hole_depth, center=false, $fn=180);
                cylinder(d=spacer_hole_screw_diameter, h=spacer_width + spacer_mount_overlap_width, center=false, $fn=180);
            }
        }
    }
}

module spacer_screw_mount() {
    
    difference() {
        prism(spacer_height, spacer_width + spacer_mount_overlap_width, spacer_width + spacer_mount_overlap_width);
        translate([0, spacer_height / 2, spacer_hole_offset]){
            spacer_screw_hole();
        }
        translate([0, 0, spacer_width + spacer_mount_overlap_width - spacer_hole_cutoff_width]){
            cube([spacer_hole_cutoff_height, spacer_height, spacer_hole_cutoff_width]);
        }
    }
}

module spacer() {
    difference(){
        union() {
            // main section
            cube([spacer_width + spacer_mount_overlap_width, length, spacer_height]);
            // overlap with limit switch mount
            translate([spacer_width, 0, -spacer_mount_overlap_height - mount_height]){
                cube([spacer_mount_overlap_width, length, spacer_mount_overlap_height + mount_height]);
            }
            // screw mounts for attaching spacer to rail
            rotate([90, 0, 0]){
                spacer_screw_mount();
            }
            translate([0, length, spacer_height]){
                rotate([-90, 0, 0]){
                    spacer_screw_mount();
                }
            }
        }
        // text decoration
        translate([spacer_width / 2 - 4, length / 2, spacer_height - text_depth]) {
            rotate([0, 0, 90]) {
                linear_extrude(text_depth){
                    text("Copernicus", font="Ariel", size=10, halign="center", valign="center");
                }
            }
        }
        translate([spacer_width - 2, length / 2, spacer_height - text_depth]) {
            rotate([0, 0, 90]) {
                linear_extrude(text_depth){
                    text("🐟 💧 🌱", font="Symbola", size=12, halign="center", valign="center");
                }
            }
        }
    }
    
}

module mount_screw_hole() {
    cylinder(d=mount_hole_screw_diameter, h=mount_height, center=false, $fn=180);
}

module mount() {
    union() {
        translate([spacer_mount_overlap_width, 0, -spacer_mount_overlap_height]) {
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