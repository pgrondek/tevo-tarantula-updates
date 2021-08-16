// MKS Gen L v1.0
width = 110;
depth = 84;
height = 25;
thickness = 3;
mount_peg = 3;
spacing = 10;

peg_up = 3;
peg_bottom = 8;
pcb_thickness = 1.5;
screw_size = height - thickness; // 10;

// 
$fn = 100;

top_part();
bottom_part();

module bottom_part() {
    union() {
        base();
        walls();
        screw_mounts();
    }
}

module top_part() {
    x = width + 2 * spacing;
    y = depth + 2 * spacing;

    d = (peg_up + 2) / 2 + 2;
    h = height - thickness + 2;

    difference() {
        translate([0, 0, height - thickness])
            cube([x, y, thickness]);

        // screw cutoffs
        screw_cutoff();
        translate([x - 8, 0, 0])
            screw_cutoff();
        translate([0, y - 8, 0])
            screw_cutoff();
        translate([x - 8, y - 8, 0])
            screw_cutoff();

        // grill
        for (i = [0 : 5])
        translate([40 + (6 * i), depth / 2.2, height - thickness * 1.5])
            grill();
    }
}

module screw_mounts() {
    d = (peg_up) + 1;
    x = width + 2 * spacing - 4;
    y = depth + 2 * spacing - 4;

    h = 0; //height - (screw_size + thickness);

    translate([d, d, h])
        rotate([0, 0, 180])
            screw_mount();

    translate([x, d, h])
        rotate([0, 0, - 90])
            screw_mount();

    translate([d, y, h])
        rotate([0, 0, 90])
            screw_mount();

    translate([x, y, h])
        screw_mount();
}


module screw_mount() {
    difference() {
        union() {
            cylinder(h = screw_size, d = peg_up + 3);
            translate([0, - peg_up, 0])
                cube([peg_up * 2, peg_up * 2, screw_size]);
            translate([- peg_up, 0, 0])
                cube([peg_up * 2, peg_up * 2, screw_size]);
        }
        translate([0, 0, - screw_size * 0.1])
            cylinder(h = screw_size * 1.3, d = peg_up);
    }
}

module base() {
    d1 = mount_peg;
    x = width + 2 * spacing;
    y = depth + 2 * spacing;

    cube([x, y, thickness]);
    translate([4 + spacing, 4 + spacing, thickness])
        peg(h = thickness);
    translate([x - (4 + spacing), 4 + spacing, thickness])
        peg(h = thickness);
    translate([x - (4 + spacing), y - (4 + spacing), thickness])
        peg(h = thickness);
    translate([(4 + spacing), y - (4 + spacing), thickness])
        peg(h = thickness);
}

module walls() {
    difference() {
        walls_basic();

        // power ports
        translate([0, 0, thickness + pcb_thickness]) {
            translate([- spacing * 1.5, 9, 5])
                cube([spacing * 2, 10.5, 13]);
            translate([- spacing * 1.5, 21, 5])
                cube([spacing * 2, 10.5, 13]);
            translate([- spacing * 1.5, 32, 5])
                cube([spacing * 2, 21, 6]);
        }

        // usb
        translate([0, 0, thickness + pcb_thickness]) {
            translate([21, - spacing * 1.5, 5])
                cube([12, spacing * 2, 11]);
        }

        // holes for mounts
        translate([30, depth + thickness * 3.5, thickness + 10])
            rotate([90, 0, 0])
                cylinder(h = thickness * 2, d = 3);
        translate([width - 30, depth + thickness * 3.5, thickness + 10])
            rotate([90, 0, 0])
                cylinder(h = thickness * 2, d = 3);
    }
}

module walls_basic() {
    x = width + 2 * spacing;
    y = depth + 2 * spacing;

    translate([0, - thickness, 0])
        cube([x, thickness, height]);
    translate([0, y, 0])
        cube([x, thickness, height]);
    translate([x, - thickness, 0])
        cube([thickness, y + 2 * thickness, height]);
    translate([- thickness, - thickness, 0])
        cube([thickness, y + 2 * thickness, height]);
}

module peg(h) {
    cylinder(h = h, d = peg_bottom);
    cylinder(h = h * 3, d = peg_up);
}

module screw_cutoff() {
    d = (peg_up + 5) / 2;
    h = height - thickness + 2;

    translate([d, d, h])
        cylinder(h = 2, d1 = 3, d2 = 6);
    translate([d, d, h - 2])
        cylinder(h = 2, d = 3);
}

module grill() {
    d = 3;
    hull() {
        cylinder(h = thickness * 2, d = d);
        translate([0, 30, 0])
            cylinder(h = thickness * 2, d = d);
    }
}