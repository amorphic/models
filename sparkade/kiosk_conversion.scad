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

module kiosk_base() {
    cube([kiosk_base_width, kiosk_base_depth, kiosk_base_height]);
}

module kiosk_body() {
    color("green"){
        cube([kiosk_body_width, kiosk_body_depth, kiosk_body_lower_height]);
    }
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

kiosk();