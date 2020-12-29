sleeve_height = 120;
inner_diameter = 43;
wall_thickness = 2;
wall_hole_diameter = 33;
separator_thickness = 4;
text_depth = 1;
text_copy = "PlanterPole";
text_font = "Ariel";
text_size = 8;
tooth_length = 0.6;
tooth_count = 6;
tooth_rotation = 360 / tooth_count;

module body() {
    union() {
        difference () {
            cylinder(d=inner_diameter, h=separator_thickness, center=true, $fn=180);
            cylinder(d=wall_hole_diameter, h=separator_thickness, center=true, $fn=180);
        }
        difference () {
            cylinder(d=inner_diameter + wall_thickness * 2, h=sleeve_height, center=true, $fn=180);
            cylinder(d=inner_diameter, h=sleeve_height, center=true, $fn=180);
        }
    }
}

module teeth() {
    for(i = [0 : tooth_rotation])
        rotate(i * tooth_rotation)
            translate([0, inner_diameter / 2])
                cylinder(r=tooth_length, h=sleeve_height, center=true, $fn=18);
}

module sleeve() {
    difference(){
        union() {
            body();
            teeth();
        }
        translate([inner_diameter / 2 + wall_thickness - text_depth, 0, sleeve_height / 5]) {
            rotate([0, 90, 0]) {
                linear_extrude(text_depth){
                    text(text_copy, font=text_font, size=text_size, halign="center", valign="center");
                }
            }
        }
    }
}

sleeve();