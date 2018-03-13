// Parameters
bracket_length = 234;
bracket_width = 50;
bracket_height = 3;
slots = 5;
slot_width = 3;
slot_height = 5;

slot_interval = bracket_length / (slots + 1);
slot_shift = slot_width + (slot_height / 2);

// Bracket
union() {
    cube([bracket_length, bracket_width, bracket_height]);
    for (x=[slot_interval:slot_interval:(bracket_length - slot_interval)]){
        translate([(x - slot_shift), 0, bracket_height]) {
            cube([slot_height, bracket_width, slot_height]);
        }
        translate([(x + slot_shift / 2), 0, bracket_height]) {
            cube([slot_height, bracket_width, slot_height]);
        }
    }
}