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
controller_material_width = 12;
controller_height_front = 140;
controller_depth = 200;
controller_pitch_top_degrees = 9;
controller_pitch_bottom_degrees = 3;
controller_top_offset = (controller_depth - controller_material_width) * tan(controller_pitch_top_degrees);
controller_height_back = controller_height_front + controller_top_offset;
controller_corner_diameter = 22;
controller_corner_radius = controller_corner_diameter / 2;
controller_top_overhang = controller_corner_radius * .6;
controller_top_depth = controller_depth + controller_top_overhang;
controller_bottom_recess = controller_corner_radius / 2;
controller_bolt_hole_diameter = 6.5;
controller_bolt_hole_offset = 20;

// joystick
joystick_plate_width = 64.9;
joystick_plate_length = 97.0;
joystick_plate_tolerance = 0.4;
joystick_plate_thickness = 1.6;
joystick_hole_diameter = 28;
joystick_button_hole_diameter = 28;
joystick_screw_hole_offset_x = 10.0;
joystick_screw_hole_offset_y = 7.5;

// faceplate
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
    linear_extrude(controller_material_width)
        hull(){        
            translate([0, controller_height_front + controller_depth * tan(controller_pitch_top_degrees), 0])
                // top triangle
                polygon(points=[
                    [0, 0],
                    [0, controller_depth * tan(controller_pitch_top_degrees) + controller_bottom_recess],
                    [controller_depth, controller_bottom_recess],
                ]);
            // bottom triangle
            polygon(points=[
                [0,0],
                [0, controller_depth * tan(controller_pitch_bottom_degrees)],
                [controller_depth, controller_depth * tan(controller_pitch_bottom_degrees)],
            ]);
            // corners
            translate([controller_depth, controller_corner_radius + controller_depth * tan(controller_pitch_bottom_degrees), 0])
                circle(d=controller_corner_diameter, $fn=180);
            translate([controller_depth,controller_height_front + controller_bottom_recess - controller_corner_radius + controller_depth * tan(controller_pitch_top_degrees), 0])
                circle(d=controller_corner_diameter, $fn=180);
        }
}

module controller_base(){
    cube([kiosk_body_width - controller_material_width * 2, controller_depth - controller_material_width * 2, controller_material_width]);
}

module controller_bolt_hole(){
    rotate([-90,0,0])
        cylinder(d=controller_bolt_hole_diameter, h=controller_material_width, $fn=180);
}

module controller_back(){
    bolt_hole_offset = controller_bolt_hole_offset + controller_material_width;
    difference(){
        cube([kiosk_body_width - controller_material_width * 2, controller_material_width, controller_height_back]);
        // bolt holes
        translate([bolt_hole_offset, 0, controller_material_width + bolt_hole_offset])
            controller_bolt_hole();
        translate([kiosk_body_width - controller_material_width * 2 - bolt_hole_offset, 0, controller_material_width + bolt_hole_offset])
            controller_bolt_hole();
        translate([bolt_hole_offset, 0, controller_height_back - bolt_hole_offset])
            controller_bolt_hole();
        translate([kiosk_body_width - controller_material_width * 2 - bolt_hole_offset, 0, controller_height_back - bolt_hole_offset])
            controller_bolt_hole();
    }
}

module controller_front(){
    difference(){
        cube([kiosk_body_width - controller_material_width * 2, controller_material_width, controller_height_front]);
        // button holes
    }
}

module controller_top(){
    difference(){
        cube([kiosk_body_width - controller_material_width * 2, controller_top_depth, controller_material_width]);
        // button holes
    }
}

module controller_button_hole(){
    cylinder(d=controller_button_hole_diameter, h=controller_material_width, $fn=180);
}

module controller_joystick_cutout(){
    
}

module controller_1p_cutout(){
    controller_button_hole();
} 

module controller_assembly(){
    base_offset = controller_depth * tan(controller_pitch_bottom_degrees) + controller_bottom_recess;
    top_z_adjust = 0.6;
    top_y_adjust = 4;
    translate([controller_material_width, 0, 0])
        color("brown")
            rotate([90, 0, -90])
                controller_side();
    translate([kiosk_body_width, 0, 0])
        color("brown")
            rotate([90, 0, -90])
                controller_side();
    translate([controller_material_width, controller_material_width-controller_depth, base_offset])
        color("brown")
            controller_base();
    translate([controller_material_width, -controller_material_width, base_offset])
        color("brown")
            controller_back();
    translate([controller_material_width, -controller_depth, base_offset])
        color("brown")
            controller_front();
    translate([controller_material_width, -controller_depth - top_y_adjust, controller_height_front + base_offset - top_z_adjust])
        color("brown")
            rotate([controller_pitch_top_degrees, 0, 0])            
                controller_top();
}    

/*
kiosk();
translate([(kiosk_base_width - kiosk_body_width) / 2,0,900]){
    controller_assembly();
}
*/

//controller_side();
//controller_base();
//controller_back();
//controller_front();
//controller_top();
controller_button_hole();

//controller_assembly();