// kiosk
kiosk_base_width = 570;
kiosk_base_depth = 570;
kiosk_base_height = 53;
kiosk_body_width = 551;
kiosk_body_depth = 125;
kiosk_body_lower_height = 1000;
kiosk_body_upper_height = 453;
kiosk_body_upper_tilt = -15;
kiosk_body_offset = 171;
kiosk_screen_cutout_width = 374;
kiosk_screen_cutout_height = 300;
kiosk_screen_cutout_depth = 10;
kiosk_screen_border_top = 69;
kiosk_screen_border_bottom = 81;
kiosk_screen_border_side = 87;

// controller
controller_height_back = 180;
controller_height_front = 140;
controller_depth = 200;
controller_corner_diameter = 20;
controller_corner_radius = controller_corner_diameter / 2;
pitch_top_degrees = 9;
pitch_bottom_degrees = 3;
material_width = 12;
faceplate_material_depth = 3;

module kiosk_base() {
    cube([kiosk_base_width, kiosk_base_depth, kiosk_base_height]);
}

module kiosk_body() {
    cube([kiosk_body_width, kiosk_body_depth, kiosk_body_lower_height]);
    translate([0, 0, kiosk_body_lower_height]){
        rotate([kiosk_body_upper_tilt,0,0]){
            difference() {
                cube([kiosk_body_width, kiosk_body_depth, kiosk_body_upper_height]);
                translate([kiosk_screen_border_side, 0, kiosk_screen_border_bottom]){
                    cube([kiosk_screen_cutout_width, kiosk_screen_cutout_depth, kiosk_screen_cutout_height]);
                }
            }
        }
    }
}

module kiosk(){
    color("red") {
        kiosk_base();
        translate([(kiosk_base_width - kiosk_body_width) / 2,kiosk_body_offset,kiosk_base_height]) {
            kiosk_body();
        }
    }
}

module controller_side(){
    linear_extrude(material_width)
        hull(){        
            translate([0, controller_height_front + controller_depth * tan(pitch_top_degrees), 0])
                // top triangle
                polygon(points=[
                    [0,0],
                    [0, controller_depth * tan(pitch_top_degrees)],
                    [controller_depth,0],
                ]);
            // bottom triangle
            polygon(points=[
                [0,0],
                [0, controller_depth * tan(pitch_bottom_degrees)],
                [controller_depth, controller_depth * tan(pitch_bottom_degrees)],
            ]);
            // corners
            translate([controller_depth,controller_corner_radius+controller_depth * tan(pitch_bottom_degrees),0])
                circle(d=controller_corner_diameter, $fn=180);
            translate([controller_depth,controller_height_front-controller_corner_radius+  controller_depth * tan(pitch_top_degrees),0])
                circle(d=controller_corner_diameter, $fn=180);
        }
}

module controller_base(){
    cube([kiosk_body_width - material_width * 2, controller_depth, material_width]);
}

module controller_assembly(){
    translate([material_width,kiosk_body_offset,0])
        rotate([270,0,270])
            controller_side();
    translate([kiosk_body_width,kiosk_body_offset,0])
        rotate([270,0,270])
            controller_side();
    translate([material_width,kiosk_body_offset-controller_depth,-material_width])
        controller_base();
}    

/*
kiosk();
translate([(kiosk_base_width - kiosk_body_width) / 2,0,900]){
    controller_assembly();
}
*/

controller_side();
controller_base();
//controller_assembly();