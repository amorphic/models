base_x = 15.5;
base_y = 16.0;
base_z = 28.0;

module base() {
    cube([base_x, base_y, base_z], center=false);
}

module cutout_1() {
    translate([0.0, 0.0, 8.0]){
        cube([8.5, base_y, 20.0], center=false);
    }
}

module cutout_2() {
    translate([0.0, 0.0, 8.0]){
        cube([base_x, 2.5, 20.0], center=false);
    }
}

module hole_1(){
    translate([6.0,0.0,5.4]){
        rotate([-90,0,0]){
            cylinder(r=1.5, h=12, center=false, $fn=180);
        }
    }
}

module hole_2(){
        rotate([0,-90,0]){
            cylinder(r=3.75, h=2, center=false, $fn=180);
        }
        translate([-2,0,0]){
            rotate([0,-90,0]){
                cylinder(r=1.4, h=12, center=false, $fn=180);
            }
        }
}

module main() {
    difference() {
        base();
        cutout_1();
        cutout_2();
        hole_1();
        translate([15.5,9.25,22.5]){
            hole_2();
        }
        translate([15.5,9.25,14.5]){
            hole_2();
        }
    }
}

main();
