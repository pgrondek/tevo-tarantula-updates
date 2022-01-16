// MKS Gen L v1.0
width = 110;
depth = 84;
height = 45;
thickness = 3;
mount_peg = 3;
spacing_y = 5;
spacing = spacing_y;
spacing_bottom = 30;
spacing_top = 10;
mount_screw = 4.5;

peg_up = 3;
peg_bottom = 8;
pcb_thickness = 1.5;
screw_size = height - thickness; // 10;

// 
$fn = 100;

top_part();
//bottom_part();

module bottom_part() {
    difference() {
        union() {
            base();
            walls();
            screw_mounts();
        }
        grill = 33;
        for (i = [0 : 15]) {
            translate([40 + (6 * i), spacing_y + 5, - thickness * 0.5])
                grill(grill);
            translate([40 + (6 * i), depth - grill - spacing_y + 5, - thickness * 0.5])
                grill(grill);
        }
    }
}

module top_part() {
    x = width + spacing_top + spacing_bottom;
    y = depth + 2 * spacing_y;

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
        grill = 33;
        for (i = [0 : 12]) {
            translate([60 + (6 * i), spacing_y + 5, height - thickness * 1.5])
                grill(grill);
            translate([60 + (6 * i), depth - grill - spacing_y + 5, height - thickness * 1.5])
                grill(grill);
        }
        
        translate([35, (depth+10)/2, height - thickness])
            fan();
    }
}

module fan() {
    
    d=2.7;
    v = [ 
     [ -16, -16, 0],
     [ -16, 16, 0],
     [ 16, 16, 0],
     [ 16, -16, 0]
    ];


    for ( i = v ) {
        translate(i)
            cylinder(d=d,h=10, center=true);
    }
    
    cylinder(d=39,h=10, center=true);
}

module screw_mounts() {
    d = (peg_up) + 1;
    x = width + spacing_top + spacing_bottom - 4;
    y = depth + 2 * spacing_y - 4;

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
    x = width + spacing_top + spacing_bottom;
    y = depth + 2 * spacing;

    cube([x, y, thickness]);
    translate([4 + spacing_bottom, 4 + spacing, thickness])
        peg(h = thickness);
    translate([x - (4 + spacing_top), 4 + spacing, thickness])
        peg(h = thickness);
    translate([x - (4 + spacing_top), y - (4 + spacing), thickness])
        peg(h = thickness);
    translate([(4 + spacing_bottom), y - (4 + spacing), thickness])
        peg(h = thickness);
}

module walls() {
    difference() {
        walls_basic();

        // usb
        translate([spacing, 0, thickness + pcb_thickness]) {
            translate([spacing_bottom + 15, - spacing * 1.5, 1.5])
                cube([15, spacing * 2, 15]);
        }

        // cable holes
        d = 25;
        y = depth + 2 * spacing_y;

        translate([- thickness * 1.5, y / 2, height / 2])
            rotate([0, 90, 0])
                translate([0, 0, 0])
                    cylinder(h = 20, d = d);

        holes_spacing = spacing_top + spacing_bottom + 0.1;

        // holes for mounts
        translate([30, depth + thickness + spacing * 2.1, 15])
            rotate([90, 0, 0])
                cylinder(h = thickness * 2, d = mount_screw);

        translate([width + holes_spacing - 30, depth + thickness + spacing * 2.1, 15])
            rotate([90, 0, 0])
                cylinder(h = thickness * 2, d = mount_screw);
    }
}

module walls_basic() {
    x = width + spacing_top + spacing_bottom;
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
        cylinder(h = 2, d1 = 3, d2 = 9);
    translate([d, d, h - 2])
        cylinder(h = 2, d = 3);
}

module grill(length = 30) {
    d = 3;
    hull() {
        cylinder(h = thickness * 2, d = d);
        translate([0, length, 0])
            cylinder(h = thickness * 2, d = d);
    }
}