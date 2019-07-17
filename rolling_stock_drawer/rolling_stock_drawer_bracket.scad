// Parameters
bracket_length = 234;
bracket_width = 48.5;
bracket_height = 3;
slots = 5;
slot_width = 3;
slot_height = 5;
notch_width = 5;
notch_height = 15;

slot_interval = bracket_length / (slots + 1);
slot_shift = (notch_width + slot_width / 2);

// Bracket
union() {
    cube([bracket_length, bracket_width, bracket_height]);
    for (x=[slot_interval:slot_interval:(bracket_length - slot_interval)]){
        translate([(x - slot_shift), 0, bracket_height]) {
            cube([notch_width, bracket_width, notch_height]);
        }
        translate([(x), 0, bracket_height]) {
            color("green") {
                cube([slot_width, bracket_width, (notch_height - slot_height)]);
            }
        }
        translate([(x + slot_shift), 0, bracket_height]) {
            cube([notch_width, bracket_width, notch_height]);
        }
    }
}