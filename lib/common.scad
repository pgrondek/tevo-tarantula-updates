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

module block_with_fillet(width, depth, height, fillet) {
    minkowski() {
        cube([width - (fillet * 2), depth - (fillet * 2), height / 2]);
        translate([fillet, fillet, 0])
            cylinder(r = fillet, h = height / 2);
    }
}
