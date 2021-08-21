$fn = 100;

//translate([4,4,0])
//    translate([11,11,0])
//        e3d_v6();

//color("red"){
//    translate([40,0,0])
//        rotate([0,-90,0])
//            fan_mount();
//}

color("green") {
    difference() {
        // part
        translate([0, 0, 0])
            cube([30, 15, 42.5]);

        // space for fan mount
        translate([40, 0, 0])
            rotate([0, - 90, 0])
                fan_mount();

        // space for extruder
        translate([4, 4, 0])
            translate([11, 11, 0])
                e3d_v6();
    }
}

module e3d_v6() {
    h0 = - 14;
    translate([- 8, - 3.5, h0])
        cube([16, 20, 12]);

    h1 = h0 + 12;
    translate([0, 0, h1])
        cylinder(d = 3, h = 2);

    h2 = h1 + 2;
    translate([0, 0, h2])
        cylinder(d = 22, h = 26);

    h3 = h2 + 26;
    translate([0, 0, h3])
        cylinder(d = 16, h = 7);

    h4 = h3 + 7;
    translate([0, 0, h4])
        cylinder(d = 12, h = 6);

    h5 = h4 + 6;
    translate([0, 0, h5])
        cylinder(d = 16, h = 3.5);

    h6 = h5 + 3.5;
    translate([0, 0, h6])
        cylinder(d = 11.5, h = 6.5, $fn = 6);
}

module fan_mount() {
    cube([30, 30, 10]);

    // screw holes
    translate([1.5 + 1.5, 1.5 + 1.5, 10])
        cylinder(d = 3, h = 5);

    translate([30 - (1.5 + 1.5), 1.5 + 1.5, 10])
        cylinder(d = 3, h = 5);

    translate([1.5 + 1.5, 30 - (1.5 + 1.5), 10])
        cylinder(d = 3, h = 5);

    translate([30 - (1.5 + 1.5), 30 - (1.5 + 1.5), 10])
        cylinder(d = 3, h = 5);

    // square nuts holes
    translate([0, 0, 12])
        cube([6, 6, 2.5]);

    translate([30 - 6, 0, 12])
        cube([6, 6, 2.5]);

    translate([0, 30 - 6, 12])
        cube([6, 6, 2.5]);

    translate([30 - 6, 30 - 6, 12])
        cube([6, 6, 2.5]);

}