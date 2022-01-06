include <../lib/common.scad>;
include <../lib/examples.scad>;

thickness = 6;
width = 65;
depth = 62;

$fn = 100;

base();

module base() {
    difference() {
        union() {
            translate([0, - thickness * 2, 0])
                block_with_fillet(width, depth + thickness * 2, thickness, 10);
            translate([0, - thickness, 0])
                mount();
        }
        big_holes();
        small_holes();
        belt_holes();
        endstop_holes();
        wheel_clerance();
    }
}

module big_holes() {
    diameter = 7;
    translate([diameter / 2 + 5, diameter / 2 + 7, - 0.1])
        cylinder(d = diameter, h = thickness * 1.1);

    translate([width - (5 + diameter / 2), diameter / 2 + 7, - 0.1])
        cylinder(d = diameter, h = thickness * 1.1);

}

module wheel_clerance() {
    diameter = 30;
    diameter2 = 7;
    translate([diameter2 / 2 + 5, diameter2 / 2 + 7, thickness])
        cylinder(d = diameter, h = thickness * 10);

    translate([width - (5 + diameter2 / 2), diameter2 / 2 + 7, thickness])
        cylinder(d = diameter, h = thickness * 10);

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

module mount() {
    translate([(width - 35) / 2, 0]) {

        rotate([90, 0, 0]) {
            difference() {
                union() {
                    block_with_fillet(35, 30, thickness, 10);
                    cube([35, 10, thickness]);
                    rotate([180, 0, 0])
                        translate([0, - 20, 0])
                            prism(35, 20, 23);
                }

                union() {
                    translate([2.5 + 2, 20, 10])
                        rotate([180, 0, 0])
                            screw_mount(length = 10, nut_size = 6, screw_size = 3, nut = "hexagon", nut_height = 30);

                    translate([2.5 + 25, 20, 10])
                        rotate([180, 0, 0])
                            screw_mount(length = 10, nut_size = 6, screw_size = 3, nut = "hexagon", nut_height = 30);
                }
            }
        }

    }
}

module endstop_holes() {
    diameter = 2;
    translate([width - (diameter / 2 + 3), diameter / 2 + 16, - 0.1])
        cylinder(d = diameter, h = thickness * 1.1);

    translate([width - (diameter / 2 + 3), diameter / 2 + 16 + 6, - 0.1])
        cylinder(d = diameter, h = thickness * 1.1);
}