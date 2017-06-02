// Shelf parameters
shelf_width = 170;
shelf_length = 140;
shelf_height = 8;

// Clip parameters
clip_width = 120;
clip_length = 25.5;
clip_height = 77;
clip_wall = 3;
clip_x_offset = 25;
clip_z_offset = 8;

// Bracket parameters
bracket_width = 30;
bracket_height = 5;

// Bracket length and angle calculated via trigonometry
bracket_length = sqrt(pow((shelf_length - clip_length),2) + pow(clip_height,2));
bracket_angle = atan(clip_height/(shelf_length-clip_length));

// Shelf
cube([shelf_width, shelf_length, shelf_height]);

translate([((shelf_width-clip_width)/2)+clip_x_offset, 0, shelf_height]) {
    // Clip
    difference() {
        cube([clip_width, clip_length, clip_height]);
        translate([0, clip_wall, clip_z_offset]) {
            cube([clip_width, clip_length-(clip_wall*2), clip_height]);
        }
    }
    // Bracket 1
    translate([0, (clip_length-clip_wall), (clip_height-bracket_height)]) {
        rotate([-(bracket_angle),0,0]) {
            cube([bracket_width, bracket_length, bracket_height]);    
        }
    }
    // Bracket 2
    translate([(clip_width-bracket_width), (clip_length-clip_wall), (clip_height-bracket_height)]) {
        rotate([-(bracket_angle),0,0]) {
            cube([bracket_width, bracket_length, bracket_height]);    
        }
    }    
}