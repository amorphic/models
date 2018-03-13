name = "J";
font = "Arial";
size = 12;

translate([7, 7, 8.2]){
    rotate([0, 0, 135]){
        linear_extrude(height=1) {
            text(name, font=font, size=size, halign="center", valign="center");
        }
    }
}
            
difference(){
    cube([16, 16, 8.2]);
    translate([0, 0, 4.1]){
        rotate([0, 90, 45]){
            cylinder(16, $fn=120, r=3);
        }
    }
}