use <text_on/text_on.scad>
use <bend.scad/bend.scad>

cooler_inner_diameter = 59;
cooler_thickness = 5;
cooler_height = 100;
cooler_base_thickness = 5;
cooler_resolution = 120;
cooler_color = "purple";

name_text = "Sarah";
name_font = "Sawasdee Regular";
name_size = 36;
name_thickness = 2;
name_color = "red";

number_text = "40";
number_font = "Sawasdee Regular";
number_size = 36;
number_thickness = 2;
number_color = "red";

cactus_text = "🌵";
cactus_font = "Symbola";
cactus_size = 36;
cactus_thickness = 2;
cactus_color = "green";

module Cooler() {
    color(cooler_color)
    difference() {
        cylinder(h = (cooler_height + cooler_base_thickness), r = ((cooler_inner_diameter + cooler_thickness) / 2), $fn = cooler_resolution);
        translate([0, 0, cooler_base_thickness]) {
            cylinder(h = cooler_height, r = (cooler_inner_diameter / 2), $fn = cooler_resolution);
        }
    }
}

module Name(thickness) {
    color(name_color);
    text_on_cylinder(t=name_text, halign="left", r1 = ((cooler_inner_diameter + cooler_thickness) / 2), r2 = ((cooler_inner_diameter + cooler_thickness) / 2), h=120, font=name_font, direction="ttb", size=15, eastwest=0, extrusion_height=.1);
}

module Number(thickness) {
    color(number_color);
    text_on_cylinder(t=number_text, halign="left", r1 = ((cooler_inner_diameter + cooler_thickness) / 2), r2 = ((cooler_inner_diameter + cooler_thickness) / 2), h=60, font=number_font, direction="ttb", size=25, eastwest=25);
}

Cooler();
Name();
Number();