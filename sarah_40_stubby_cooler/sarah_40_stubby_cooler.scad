use <text_on/text_on.scad>

cooler_inner_diameter = 59;
cooler_thickness = 3;
cooler_height = 100;
cooler_base_thickness = 5;
cooler_base_cutout_diameter = 45;
cooler_square_width=14;
cooler_square_v_gap=10;
cooler_resolution = 120;
cooler_text_thickness = 2.4;
cooler_color = "purple";

name_text = "Sarah";
name_font = "Sawasdee Regular";
name_size = 15;
name_ew_position = 0;
name_z_position = 120;
name_color = "red";

number_text = "40";
number_font = "Sawasdee Regular";
number_size = 20;
number_ew_position = 24;
number_z_position = 62;
number_color = "yellow";

cacti_text = "🌵   🌵";
cacti_font = "Symbola";
cacti_size = 20;
cacti_ew_position = -21;
cacti_z_position = 66;
cacti_color = "green";

id_text = str("ID:", cooler_inner_diameter);
id_font = "Sawasdee Regular";
id_size = 4;
id_ew_position = 212;
id_z_position = 10;
id_color = "yellow";

module SquareRing(square_width, start_position) {
    for (z=[start_position:45:(start_position + 180)]) {
        rotate([0,45,z]){
            cube([square_width, (cooler_inner_diameter + (cooler_thickness * 2)), square_width], center=true);
        }
    }
}

module CoolerFrontMask(xy_advance) {
    box_side = cooler_inner_diameter + cooler_thickness;
    box_height = cooler_height + cooler_base_thickness;
    translate([(box_side / xy_advance), -(box_side / xy_advance), (box_height / 2)]){
        rotate([0,0,45]) {
            cube([box_side, box_side, box_height], center=true);
        }
    }
}

module CoolerSurfaceMask() {
    difference() {
        cylinder(h = (cooler_height + cooler_base_thickness), r = ((cooler_inner_diameter / 2) + cooler_thickness + 10), $fn = cooler_resolution);
        cylinder(h = (cooler_height + cooler_base_thickness), r = ((cooler_inner_diameter / 2) + cooler_thickness), $fn = cooler_resolution);
    }
}

module Squares(gap) {
    // Bottom
    translate([0,0,((cooler_square_width / 2) + gap)]){ SquareRing(cooler_square_width, 22.5); };
    // Middle
    difference() {
        translate([0,0,((cooler_square_width / 2) + (gap * 2) + cooler_square_width)]){ SquareRing(cooler_square_width, 0); };
        CoolerFrontMask(4.2);
    }
    difference() {
        translate([0,0,((cooler_square_width / 2) + (gap * 3) + (cooler_square_width * 2))]){ SquareRing(cooler_square_width, 22.5); };
        CoolerFrontMask(2.6);
    }
    // Top
    translate([0,0,(cooler_height + cooler_base_thickness - (cooler_square_width / 2 + gap))]){ SquareRing(cooler_square_width, 0); };  
}

module Cooler() {
    color(cooler_color)
    difference() {
        difference() {
            cylinder(h = (cooler_height + cooler_base_thickness), r = ((cooler_inner_diameter / 2) + cooler_thickness), $fn = cooler_resolution);
            translate([0, 0, cooler_base_thickness]) {
                cylinder(h = cooler_height, r = (cooler_inner_diameter / 2), $fn = cooler_resolution);
            }
            cylinder(h = cooler_base_thickness, r = (cooler_base_cutout_diameter / 2), $fn = cooler_resolution);
        }
        Squares(cooler_square_v_gap);
        AllText();
    }      
}

module CoolerText(text_string, text_font, text_size, ew_position, z_position, text_color, text_thickness) {
    color(text_color) {
        radius = ((cooler_inner_diameter / 2) + cooler_thickness - text_thickness);
        difference() {
            text_on_cylinder(t=text_string, halign="left", r1 = radius, r2 = radius, h=z_position, font=text_font, direction="ttb", size=text_size, eastwest=ew_position, extrusion_height=text_thickness + 1);
            CoolerSurfaceMask();
        }
    }
}

module NameText() {
    CoolerText(name_text, name_font, name_size, name_ew_position, name_z_position, name_color, cooler_text_thickness);
}

module NumberText() {
    CoolerText(number_text, number_font, number_size, number_ew_position, number_z_position, number_color, cooler_text_thickness);
}

module IDText() {
    CoolerText(id_text, id_font, id_size, id_ew_position, id_z_position, id_color, cooler_text_thickness);
}

module CactiText() {
    CoolerText(cacti_text, cacti_font, cacti_size, cacti_ew_position, cacti_z_position, cacti_color, cooler_text_thickness);
}

module AllText() {
    NameText();
    NumberText();
    IDText();
    CactiText();
}

Cooler();
//NameText();
//NumberText();
//IDText();
//CactiText();