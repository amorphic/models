brake_radius = 75;
brake_thickness = 5;
brake_width = 54;
brake_cutout_height = 25;
brake_resolution = 360;

mount_length = 30;
mount_thickness = 3;
mount_width = 48;
mount_angle = 15;

screw_hole_diameter = 4;
screw_hole_x_long = 27;
screw_hole_x_short = 22;
screw_hole_1_z = 12;
screw_hole_2_z = 24;
screw_hole_3_z = 36;
screw_hole_resolution = 120;

// brake
difference() {
    difference() {
        difference() {
            cylinder(h=brake_width, $fn=brake_resolution, r=brake_radius);
            cylinder(h=brake_width, $fn=brake_resolution, r=(brake_radius-brake_thickness));
        }
        union() {
            translate([-brake_radius,0,0]){
                cube([brake_radius, brake_radius, brake_width]);
            }
            translate([-brake_radius,-brake_radius,0]){
                cube([brake_radius, brake_radius, brake_width]);
            }
            translate([0,-brake_radius,0]){
                cube([brake_radius, brake_radius, brake_width]);
            }
        }
    }
    union() {
        translate([(brake_radius - brake_thickness * 2), 0, 0]) {
            cube([(brake_thickness * 2), brake_cutout_height, ((brake_width - mount_width) / 2)]);
        }
        translate([(brake_radius - brake_thickness * 2), 0, ((brake_width - ((brake_width - mount_width) / 2)))]) {
            cube([(brake_thickness * 2), brake_cutout_height, ((brake_width - mount_width) / 2)]);
        }
    }
}
//mount
translate([(brake_radius - brake_thickness), 0, ((brake_width - mount_width) / 2)]) {
    rotate([0,0,-mount_angle]) {
        difference() {     
            cube([(mount_length + brake_thickness), mount_thickness, mount_width]);
            //screw holes - adjust these to suit
            union() {
                //hole 1
                translate([screw_hole_x_long, mount_thickness + 1, screw_hole_1_z]) {
                    rotate([90, 0, 0]) {
                        cylinder(h=mount_thickness + 2, $fn=screw_hole_resolution, d=screw_hole_diameter);
                    }
                }
                //hole 2
                translate([screw_hole_x_short, mount_thickness + 1, screw_hole_2_z]) {
                    rotate([90, 0, 0]) {
                        cylinder(h=mount_thickness + 2, $fn=screw_hole_resolution, d=screw_hole_diameter);
                    }
                }
                //hole 2
                translate([screw_hole_x_long, mount_thickness + 1, screw_hole_3_z]) {
                    rotate([90, 0, 0]) {
                        cylinder(h=mount_thickness + 2, $fn=screw_hole_resolution, d=screw_hole_diameter);
                    }
                }
            }
        }
    }
}