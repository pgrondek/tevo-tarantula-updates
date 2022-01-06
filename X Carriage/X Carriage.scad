include <../lib/common.scad>;

thickness = 6;
width = 65;
depth = 62;
height = 50;

$fn = 100;

base();

module base() {
    difference() {
        union() {
            translate([0, - thickness, 0])
                block_with_fillet(width, depth + thickness, thickness, 10);
            mount();
        }
        big_holes();
        small_holes();
        belt_holes();
        endstop_holes();
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

module mount() {
    translate([(width - 35) / 2, 0]) {
        rotate([90, 0, 0]) {
            difference() {
                union() {
                    block_with_fillet(35, 30, thickness, 10);
                    cube([35, 10, thickness]);
                }

                union() {
                    translate([2.5 + 2, 20, 10])
                        rotate([180, 0, 0])
                            screw_mount(length = 10, nut_size = 6, screw_size = 3, nut = "hexagon");

                    translate([2.5 + 25, 20, 10])
                        rotate([180, 0, 0])
                            screw_mount(length = 10, nut_size = 6, screw_size = 3, nut = "hexagon");
                }
            }
        }

    }
}

module screw_mount(length, nut_size, screw_size, nut = "none") {
    translate([screw_size / 2, screw_size / 2, 0]) {
        cylinder(d = screw_size + 3, h = screw_size);
        cylinder(d = screw_size, h = length);
        if (nut == "hexagon") {
            translate([0, 0, length - 3])
                cylinder(d = nut_size, h = 3, $fn = 6);
        } else if (nut == "square") {
            translate([- nut_size / 2, - nut_size / 2, length - 3])
                cube([nut_size, nut_size, 3]);
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