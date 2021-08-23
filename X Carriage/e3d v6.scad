include <../lib/common.scad>;

$fn = 100;
width = 35;
depth = 30;

e3d_width = 22;

part = "mount";

difference() {
    distance = width / 2;

    // part
    if (part == "mount") {
        translate([0, 0, 0])
            cube([width, 15, 42.5]);
    } else if (part == "cover") {
        translate([0, 15, 0])
            cube([width, 15, 42.5]);

        // mount for part cooling fan shroud
        translate([distance + 11, 27, - 6])
            cube([6, 3, 6]);
        translate([distance + 5 + 0.2146, 27, 0.895])
            rotate([0, 50, 0])
                cube([9, 3, 6]);
    }

    // space for fan mount
    translate([width + 10, 0, 0])
        rotate([0, - 90, 0])
            fan_mount();

    // space for extruder
    translate([(width - e3d_width) / 2, 4, 0])
        e3d_v6();

    screw_mounts();

    // hole for part cooling fan
    translate([distance + 5, depth, 37])
        rotate([90, 0, 0])
            translate([1.5, 1.5, 0])
                cylinder(d = 3, h = 5);

    translate([distance + 12.5, depth, - 4.5])
        rotate([90, 0, 0])
            translate([1.5, 1.5, 0])
                cylinder(d = 4, h = 5);
}

module e3d_v6() {
    translate([11, 11, 0]) {
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
}

module fan_mount() {
    fan_size = 30;
    fan_thickness = 10;

    cube([fan_size, fan_size, fan_thickness]);

    // screw holes
    translate([1.5 + 1.5, 1.5 + 1.5, fan_thickness])
        cylinder(d = 3, h = 10);

    translate([fan_size - (1.5 + 1.5), 1.5 + 1.5, fan_thickness])
        cylinder(d = 3, h = 10);

    translate([1.5 + 1.5, fan_size - (1.5 + 1.5), fan_thickness])
        cylinder(d = 3, h = 10);

    // fan duct
    translate([1, 1, 0])
        translate([(fan_size / 2) - 1, (fan_size / 2) - 1, 0])
            cylinder(d1 = fan_size - 2, d2 = 22, h = width / 2 + fan_thickness);

    translate([1, 1, 0])
        translate([(fan_size / 2) - 1, (fan_size / 2) - 1, width / 2 + fan_thickness])
            cylinder(d = 22, h = width / 2 + 0.1);
}

module screw_mounts() {
    screw_cover_mounts();
    screw_x_carriage_mount();
}

module screw_cover_mounts() {
    screw_distance = 27;
    screw_size = 3;
    length = 18;

    distance_from_edge = (width - screw_distance) / 2;

    // cover mount
    translate([distance_from_edge, 24, 29])
        rotate([90, 0, 0]) {
            translate([screw_size, screw_size, 0])
                rotate([0, 0, 180])
                    screw_mount(length = length, nut_size = 6, screw_size = screw_size, nut = "square+");
            translate([1.5, 1.5, - 20])
                cylinder(d = 6, h = 20);
        }

    translate([width - distance_from_edge - screw_size, 24, 29])
        rotate([90, 0, 0]) {
            screw_mount(length = length, nut_size = 6, screw_size = screw_size, nut = "square+");
            translate([1.5, 1.5, - 20])
                cylinder(d = 6, h = 20);
        }
}

module screw_x_carriage_mount() {
    screw_distance = 23;
    screw_size = 3;

    distance_from_edge = (width - screw_distance) / 2;

    // X carriage mount
    translate([distance_from_edge, 15, 35])
        rotate([90, 0, 0])
            screw_mount(length = 20, nut_size = 6, screw_size = 3, nut = "none");

    translate([width - (distance_from_edge + screw_size), 15, 35])
        rotate([90, 0, 0])
            screw_mount(length = 20, nut_size = 6, screw_size = 3, nut = "none");
}