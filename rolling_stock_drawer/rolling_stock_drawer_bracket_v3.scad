// Parameters
bracket_length = 234;
bracket_width = 48.0;
bracket_height = 1;
notch_length = 32.1;
notch_width = 3.1;
section_count = 6;
section_length = bracket_length / section_count;

module notches() {
    for (x=[1:1:section_count - 1]) {
        translate([x * section_length - notch_width / 2, (bracket_width - notch_length) / 2, ]) {
            cube([notch_width, notch_length, bracket_height]);
        }
    }
}

module bracket() {
    difference() {
        cube([bracket_length, bracket_width, bracket_height]);
        notches();
    }
}

projection() {
    bracket();
}