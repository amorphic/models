/* 3d-printed parts:

- joystick controller mount: https://www.thingiverse.com/thing:3700981/files
- pi3 / tinkerboard mount: https://www.thingiverse.com/thing:922740/files
*/

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
kiosk_hole_width = 90;
kiosk_hole_height = 15;
kiosk_hole_surround_width = 150;
kiosk_hole_surround_height = 72;
kiosk_hole_surround_depth = 2;
kiosk_hole_surround_offset = 190;
kiosk_hole_surround_corner_radius = 10;
kiosk_controller_offset = 50;

// faceplate
faceplate_material_thickness = 3;

// controller
controller_material_thickness = 12;
controller_height_front = 140;
controller_depth = 200;
controller_pitch_top_degrees = 9;
controller_pitch_bottom_degrees = 3;
controller_corner_diameter = 22;
controller_corner_radius = controller_corner_diameter / 2;
controller_bottom_recess = controller_corner_radius / 2;
controller_top_offset = (controller_depth - controller_material_thickness) * tan(controller_pitch_top_degrees);
controller_top_recess = controller_corner_radius / 2;
controller_top_overhang = controller_corner_radius * .6;
controller_top_depth = controller_depth + controller_top_overhang;
controller_height_back = controller_height_front + controller_top_offset;
controller_height_side = controller_depth * tan(controller_pitch_bottom_degrees) + controller_bottom_recess + controller_height_front + controller_depth * tan(controller_pitch_top_degrees) + controller_material_thickness + controller_top_recess + faceplate_material_thickness;
controller_bolt_hole_diameter = 8.5;
controller_bolt_hole_offset = 14;
controller_player_button_offset = 18;
controller_coin_button_offset = 36;
controller_offset = 50;
controller_cable_hole_width = 15;
controller_base_fit = 2;
controller_p1_offset_x = 30;
controller_p2_offset_x = 290;
controller_offset_y = 50;
 
// joystick
joystick_plate_width = 64.9;
joystick_plate_length = 97.0;
joystick_plate_tolerance = 0.4;
joystick_plate_thickness = 1.6;
joystick_plate_corner_radius = 5;
joystick_notch_width = 25;
joystick_notch_height = 6;
joystick_hole_diameter = 28;
joystick_button_hole_diameter = 30; // Standard 28mm + 2mm clearance
joystick_buttons_space = 63; // https://www.slagcoin.com/joystick/layout.html
joystick_screw_hole_diameter = 3;
joystick_screw_hole_offset_x = 10.0;
joystick_screw_hole_offset_y = 7.5;

// cutout
cutout_space = 20;

module kiosk_base(){
    cube([kiosk_base_width, kiosk_base_depth, kiosk_base_height]);
}

module kiosk_body(){
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

module kiosk_hole_surround(){
    kiosk_hole_surround_corner_diameter = kiosk_hole_surround_corner_radius * 2;
    rotate([90, 0, 0]){
        difference(){            
            translate([kiosk_hole_surround_corner_radius, kiosk_hole_surround_corner_radius, -kiosk_hole_surround_depth])
                hull(){
                    cylinder(r=kiosk_hole_surround_corner_radius, h=kiosk_hole_surround_depth, $fn=180, center = false);
                    translate([0, kiosk_hole_surround_height - kiosk_hole_surround_corner_diameter, 0])
                        cylinder(r=kiosk_hole_surround_corner_radius, h=kiosk_hole_surround_depth, $fn=180, center = false);
                    translate([kiosk_hole_surround_width - kiosk_hole_surround_corner_diameter, kiosk_hole_surround_height - kiosk_hole_surround_corner_diameter, 0])
                        cylinder(r=kiosk_hole_surround_corner_radius, h=kiosk_hole_surround_depth, $fn=180, center = false);
                    translate([kiosk_hole_surround_width - kiosk_hole_surround_corner_diameter, 0, 0])
                        cylinder(r=kiosk_hole_surround_corner_radius, h=kiosk_hole_surround_depth, $fn=180, center = false);
                }
            translate([kiosk_hole_surround_width / 2 - kiosk_hole_width / 2, kiosk_hole_surround_height / 2 - kiosk_hole_height / 2, -kiosk_hole_surround_depth])
                cube([kiosk_hole_width, kiosk_hole_height, kiosk_hole_surround_depth]);
        }
    }
}

module kiosk(){
    color("red") {
        kiosk_base();
        translate([(kiosk_base_width - kiosk_body_width) / 2,kiosk_body_offset,kiosk_base_height])
            kiosk_body();
        translate([kiosk_body_width / 2 - kiosk_hole_surround_width / 2, kiosk_body_offset - kiosk_hole_surround_depth, kiosk_body_lower_height + kiosk_base_height - kiosk_hole_surround_height - kiosk_hole_surround_offset])
            kiosk_hole_surround();
    }
}

module controller_side(){
    top_corner_y = controller_depth * tan(controller_pitch_bottom_degrees) + controller_bottom_recess + controller_height_front + controller_material_thickness + faceplate_material_thickness + controller_top_recess;
    linear_extrude(controller_material_thickness){
        hull(){
            // top triangle            
            translate([0, top_corner_y, 0])
                    polygon(points=[
                        [0, 0],
                        [0, controller_depth * tan(controller_pitch_top_degrees)],
                        [controller_depth, 0],
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
            translate([controller_depth, top_corner_y - controller_corner_radius, 0])
                    circle(d=controller_corner_diameter, $fn=180);
        }
    }
}

module controller_base(){
    cube([kiosk_body_width - controller_material_thickness * 2 - controller_base_fit, controller_depth - controller_material_thickness * 2 - controller_base_fit, controller_material_thickness]);
}

module controller_bolt_hole(){
    rotate([-90,0,0])
        cylinder(d=controller_bolt_hole_diameter, h=controller_material_thickness, $fn=180);
}

module controller_back(){
    bolt_hole_offset = controller_bolt_hole_offset + controller_material_thickness;
    cable_hole_offset = controller_cable_hole_width;
    difference(){
        cube([kiosk_body_width - controller_material_thickness * 2, controller_material_thickness, controller_height_back]);
        // bolt holes
        translate([bolt_hole_offset, 0, bolt_hole_offset])
            controller_bolt_hole();
        translate([kiosk_body_width - controller_material_thickness * 2 - bolt_hole_offset, 0, bolt_hole_offset])
            controller_bolt_hole();
        translate([bolt_hole_offset, 0, controller_height_back - bolt_hole_offset])
            controller_bolt_hole();
        translate([kiosk_body_width - controller_material_thickness * 2 - bolt_hole_offset, 0, controller_height_back - bolt_hole_offset])
            controller_bolt_hole();
        // cable hole
        translate([(kiosk_body_width - controller_material_thickness * 2) / 2 - controller_cable_hole_width / 2, 0, controller_material_thickness])
            cube([controller_cable_hole_width, controller_material_thickness, kiosk_hole_height]);
    }
}

module controller_front(){
    panel_width = kiosk_body_width - controller_material_thickness * 2;
    difference(){
        cube([panel_width, controller_material_thickness, controller_height_front]);
        // p1
        translate([panel_width / 2 - controller_player_button_offset, controller_material_thickness, controller_height_front / 2])
            rotate([90, 0, 0])
                joystick_button_hole();
        // p2
        translate([panel_width / 2 + controller_player_button_offset, controller_material_thickness, controller_height_front / 2])
            rotate([90, 0, 0])
                joystick_button_hole();
        // coin 1
        translate([panel_width - controller_coin_button_offset, controller_material_thickness, controller_height_front / 2])
            rotate([90, 0, 0])
                joystick_button_hole();
        // coin 2
        translate([controller_coin_button_offset, controller_material_thickness, controller_height_front / 2])
            rotate([90, 0, 0])
                joystick_button_hole();
    }
}

module controller_top(){
    difference(){
        cube([kiosk_body_width - controller_material_thickness * 2, controller_top_depth, controller_material_thickness]);
        p1_offset_x = 30;
        p2_offset_x = 290;
        offset_y = 50;
        // p1
        translate([p1_offset_x, offset_y, 0])
            controller_1p_cutout();
        // p2
        translate([p2_offset_x, offset_y, 0])
            controller_1p_cutout();
    }
}

module controller_faceplate(){
    projection() {
        difference() {
            cube([kiosk_body_width - controller_material_thickness * 2, controller_top_depth, faceplate_material_thickness]);
            // p1
            translate([controller_p1_offset_x, controller_offset_y, 0])
                controller_1p_cutout_faceplate();
            // p2
            translate([controller_p2_offset_x, controller_offset_y, 0])
                controller_1p_cutout_faceplate();
        }
    }
}

module joystick_button_hole(){
    cylinder(d=joystick_button_hole_diameter, h=controller_material_thickness, $fn=180);
}

module joystick_screw_hole(){
    cylinder(d=joystick_screw_hole_diameter, h=controller_material_thickness, $fn=180);
}



module joystick_plate_recess(){
    translate([joystick_plate_corner_radius, joystick_plate_corner_radius, -joystick_plate_thickness - joystick_plate_tolerance])
        linear_extrude(joystick_plate_thickness + joystick_plate_tolerance){
            hull(){
                circle(r=joystick_plate_corner_radius, $fn=180);
                translate([joystick_plate_width - joystick_plate_corner_radius * 2, 0, 0])
                    circle(r=joystick_plate_corner_radius, $fn=180);
                translate([joystick_plate_width - joystick_plate_corner_radius * 2, joystick_plate_length - joystick_plate_corner_radius * 2, 0])
                    circle(r=joystick_plate_corner_radius, $fn=180);
                translate([0, joystick_plate_length - joystick_plate_corner_radius * 2, 0])
                    circle(r=joystick_plate_corner_radius, $fn=180);
            }
        }
}

module joystick_body_recess(){
    union(){
        // main part
        translate([joystick_plate_corner_radius, joystick_plate_corner_radius, 0]){
            linear_extrude(controller_material_thickness){            
                hull(){
                    circle(r=joystick_plate_corner_radius, $fn=180);
                    translate([joystick_plate_width - joystick_plate_corner_radius * 2, 0, 0])
                        circle(r=joystick_plate_corner_radius, $fn=180);
                    translate([joystick_plate_width - joystick_plate_corner_radius * 2, joystick_plate_width - joystick_plate_corner_radius * 2, 0])
                        circle(r=joystick_plate_corner_radius, $fn=180);
                    translate([0, joystick_plate_width - joystick_plate_corner_radius * 2, 0])
                        circle(r=joystick_plate_corner_radius, $fn=180);
                }
            }
        }
        // notches
        translate([joystick_plate_width / 2 - joystick_notch_width / 2, -joystick_notch_height, 0])
            cube([joystick_notch_width, joystick_notch_height, controller_material_thickness]);
        translate([joystick_plate_width / 2 - joystick_notch_width / 2, joystick_plate_width, 0])
            cube([joystick_notch_width, joystick_notch_height, controller_material_thickness]);
    }
}

module controller_joystick_cutout(){
    // joystick plate recess
    translate([0, 0, controller_material_thickness])
        joystick_plate_recess();
    // joystick_body_recess
    translate([0, joystick_plate_length / 2 - joystick_plate_width / 2, 0])
        joystick_body_recess();
    // joystick screw holes
    translate([joystick_screw_hole_offset_x, joystick_screw_hole_offset_y, 0])
        joystick_screw_hole();
    translate([joystick_plate_width - joystick_screw_hole_offset_x, joystick_screw_hole_offset_y, 0])
        joystick_screw_hole();
    translate([joystick_plate_width - joystick_screw_hole_offset_x, joystick_plate_length - joystick_screw_hole_offset_y, 0])
        joystick_screw_hole();
    translate([joystick_screw_hole_offset_x, joystick_plate_length - joystick_screw_hole_offset_y, 0])
        joystick_screw_hole();
}

module controller_buttons_row(){
    translate([joystick_button_hole_diameter / 2, joystick_button_hole_diameter / 2, 0])
        joystick_button_hole();
    translate([joystick_button_hole_diameter / 2 + 31.25, joystick_button_hole_diameter / 2 + 18, 0])
        joystick_button_hole();
    translate([joystick_button_hole_diameter / 2 + 67.25, joystick_button_hole_diameter / 2 + 18, 0])
        joystick_button_hole();
    translate([joystick_button_hole_diameter / 2 + 102.5, joystick_button_hole_diameter / 2 + 9, 0])
        joystick_button_hole();
}

module controller_buttons_cutout(){
    controller_buttons_row();
    translate([0, 39, 0])
        controller_buttons_row();
}

module controller_1p_cutout(){
    controller_joystick_cutout();
    translate([joystick_plate_width / 2 - joystick_button_hole_diameter / 2 + joystick_buttons_space, joystick_plate_length / 2 - joystick_button_hole_diameter / 2 - 18, 0])
        controller_buttons_cutout();
}

module controller_1p_cutout_faceplate(){
    translate([joystick_plate_width / 2, joystick_plate_length / 2, 0])
            cylinder(d=joystick_hole_diameter, h=controller_material_thickness, $fn=180);
    translate([joystick_plate_width / 2 - joystick_button_hole_diameter / 2 + joystick_buttons_space, joystick_plate_length / 2 - joystick_button_hole_diameter / 2 - 18, 0])
        controller_buttons_cutout();
}

module controller_assembly(){
    base_offset = controller_depth * tan(controller_pitch_bottom_degrees) + controller_bottom_recess;
    echo(base_offset);
   
    // arbitrary magic
    top_z_adjust = 0.6;
    top_y_adjust = 4;
    
    translate([controller_material_thickness, 0, 0])
        color("BurlyWood")
            rotate([90, 0, -90])
                controller_side();
    translate([kiosk_body_width, 0, 0])
        color("BurlyWood")
            rotate([90, 0, -90])
                controller_side();
    
    translate([controller_material_thickness, controller_material_thickness - controller_depth - kiosk_hole_surround_depth / 2, base_offset])
        color("BurlyWood")
            controller_base();
    
    translate([controller_material_thickness, -controller_material_thickness - kiosk_hole_surround_depth, base_offset])
        color("BurlyWood")
            controller_back();
    
    translate([controller_material_thickness, -controller_depth - kiosk_hole_surround_depth, base_offset])
        color("BurlyWood")
            controller_front();
    translate([controller_material_thickness, -controller_depth - top_y_adjust, controller_height_front + base_offset - top_z_adjust])
        color("BurlyWood")
            rotate([controller_pitch_top_degrees, 0, 0])            
                controller_top();
}    

module kiosk_conversion(){
    kiosk();
    controller_z = kiosk_base_height + kiosk_body_lower_height;
    translate([(kiosk_base_width - kiosk_body_width) / 2, kiosk_body_offset, controller_z - controller_height_side - controller_offset]){
        controller_assembly();
    }
}

module cutout(){
    controller_side();
    translate([kiosk_body_width - controller_material_thickness * 2, 0, 0])
        mirror([1, 0, 0]) controller_side();
    translate([0, controller_height_side + cutout_space, 0])
        controller_base();
    translate([0, controller_height_side + cutout_space * 2.5 + controller_height_back * 2, 0])
        rotate([90, 0, 0])
            controller_back();
    translate([0, controller_height_side + cutout_space * 4 + controller_height_back * 2 + controller_height_front, 0])
        rotate([90, 0, 0])
            controller_front();
    translate([0, controller_height_side + cutout_space * 4 + controller_height_back + controller_height_front + controller_depth, 0])
            controller_top();
}

//controller_side();
//controller_base();
//controller_back();
//controller_front();
//controller_top();
//controller_faceplate();

kiosk_conversion();
//controller_assembly();
//cutout();