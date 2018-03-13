clip_width = 150;
clip_length = 25.5;
clip_height = 77;
clip_wall = 3;
clip_z_offset = 8;
clip_color = "purple";

name_text = "Juliet";
name_font = "Sawasdee Regular";
name_size = 36;
name_thickness = 2;
name_color = "red";

holder_width = 150;
holder_length = 45;
holder_height = 87;
holder_wall = 3;
holder_z_offset = 8;
holder_color = "purple";

module Clip() {
    color(clip_color)
    difference() {
        cube([clip_width, clip_length, clip_height]);
        translate([0, clip_wall, clip_z_offset]) {
            cube([clip_width, clip_length-(clip_wall*2), clip_height]);
        }
    }
}

module Name(thickness) {
    color(name_color)
    translate([(holder_width / 2), (holder_length - name_thickness), -(holder_height / 2)]) {
        rotate([90, 180, 180]){
            linear_extrude(height=thickness) {
                text(name_text, font=name_font, size=name_size, halign="center", valign="center");
            }
        }
    }
}

module Holder() {
    color(holder_color)
    translate([0, 0, -(holder_height)]) {
        difference() {
            cube([holder_width, holder_length, holder_height]);
            translate([0, holder_wall, -holder_z_offset]) {
                cube([holder_width, holder_length-(holder_wall*2), holder_height]);
            }
   
        }
    }
}

module HolderSansName() {
    difference() {
        Holder();
        Name(thickness=(name_thickness + 1));
    }
}

Clip();
HolderSansName();
Name(name_thickness);