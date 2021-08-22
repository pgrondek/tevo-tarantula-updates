include <../lib/common.scad>;

$fn = 100;

part = "cover";

difference() {
    // part
    if (part == "mount") {
        translate([0, 0, 0])
            cube([30, 15, 42.5]);
    } else if (part == "cover") {
        translate([0, 15, 0])
            cube([30, 15, 42.5]);
        translate([26, 27, - 6])
            cube([6, 3, 6]);

        translate([20.2146, 27, 0.895])
            rotate([0, 50, 0])
                cube([9, 3, 6]);
    }

    // space for fan mount
    translate([40, 0, 0])
        rotate([0, - 90, 0])
            fan_mount();

    // space for extruder
    translate([4, 4, 0])
        translate([11, 11, 0])
            e3d_v6();

    screw_mounts();


    // hole for part cooling fan
    translate([20, 30, 37])
        rotate([90, 0, 0])
            translate([1.5, 1.5, 0])
                cylinder(d = 3, h = 5);

    translate([27.5, 30, - 4.5])
        rotate([90, 0, 0])
            translate([1.5, 1.5, 0])
                cylinder(d = 4, h = 5);
}

module e3d_v6() {
    h0 = - 14;
    rotate([0, 0, 180])
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
        cylinder(d = 3, h = 10);

    translate([30 - (1.5 + 1.5), 1.5 + 1.5, 10])
        cylinder(d = 3, h = 10);

    translate([1.5 + 1.5, 30 - (1.5 + 1.5), 10])
        cylinder(d = 3, h = 10);

    // fan duct
    translate([1, 1, 0])
        translate([14, 14, 0])
            cylinder(d1 = 28, d2 = 22, h = 25);

    translate([1, 1, 0])
        translate([14, 14, 20])
            cylinder(d = 22, h = 25);
}

module screw_mounts() {
    // cover mount
    translate([1.5, 24, 29])
        rotate([90, 0, 0]) {
            screw_mount(length = 17, nut_size = 6, screw_size = 3, nut = "square");
            translate([1.5, 1.5, - 20])
                cylinder(d = 6, h = 20);
        }

    translate([25.5, 24, 29])
        rotate([90, 0, 0]) {
            screw_mount(length = 17, nut_size = 6, screw_size = 3, nut = "square");
            translate([1.5, 1.5, - 20])
                cylinder(d = 6, h = 20);
        }

    // X carriage mount
    translate([2, 15, 35])
        rotate([90, 0, 0])
            screw_mount(length = 20, nut_size = 6, screw_size = 3, nut = "none");

    translate([25, 15, 35])
        rotate([90, 0, 0])
            screw_mount(length = 20, nut_size = 6, screw_size = 3, nut = "none");
}
