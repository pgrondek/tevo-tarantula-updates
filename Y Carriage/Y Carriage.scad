thickness = 6;
width = 75;
depth = 64;
height = 50;

$fn = 100;

base();

color("green") {

}

module base() {
    difference() {
        union() {
            block_with_fillet(width, depth, thickness, 10);
            cube([width, 10, thickness]);
        }
        big_holes();
        small_holes();
        belt_holes();
    }
}

module big_holes() {
    diameter = 7;
    translate([diameter / 2 + 5, diameter / 2 + 7, - 0.1])
        cylinder(d = diameter, h = thickness * 1.1);

    translate([width - (5 + diameter / 2), diameter / 2 + 7, - 0.1])
        cylinder(d = diameter, h = thickness * 1.1);

}

module small_holes() {
    diameter = 5;

    translate([diameter / 2 + 5, depth - (diameter / 2 + 7), - 0.1])
        cylinder(d = diameter, h = thickness * 1.1);

    translate([width - (5 + diameter / 2), depth - (diameter / 2 + 7), - 0.1])
        cylinder(d = diameter, h = thickness * 1.1);
}

module belt_holes() {
    hole_width = 4;
    hole_depth = 9;
    offset_from_edge = 4;

    translate([offset_from_edge, (depth - 9) / 2, - 0.1])
        cube([hole_width, hole_depth, thickness + 0.2]);
    translate([width - (offset_from_edge + hole_width), (depth - 9) / 2, - 0.1])
        cube([hole_width, hole_depth, thickness + 0.2]);

}

module block_with_fillet(width, depth, height, fillet) {
    minkowski() {
        cube([width - (fillet * 2), depth - (fillet * 2), height / 2]);
        translate([fillet, fillet, 0])
            cylinder(r = fillet, h = height / 2);
    }
}