
// MKS Gen L v1.0
width=110;
depth=84;
height=25;
thickness=2;
mount_peg=3;
spacing=2;

peg_up=3;
peg_bottom=8;
pcb_thickness=1.5;

// 
$fn=100;

base(mount_peg);
walls();

color("green") {
}

module base(d1){
    x = width + 2*spacing;
    y = depth + 2*spacing;
    
    cube([x, y, thickness]);
    translate([4 + spacing , 4 + spacing, thickness]) 
        peg(h= thickness);
    translate([x-(4+spacing), 4 + spacing, thickness])
        peg(h= thickness);
    translate([x-(4+spacing), y-(4+spacing), thickness])
        peg(h= thickness);
    translate([(4+spacing), y-(4+spacing), thickness])
        peg(h= thickness);
}

module walls(){
    difference() {
        walls_basic();
        
        // power ports
        translate([0,0,thickness+ pcb_thickness]){
            translate([-spacing*1.5, 9, 5])
                cube([spacing*2, 10.5, 13]);
            translate([-spacing*1.5, 21, 5])
                cube([spacing*2, 10.5, 13]);
            translate([-spacing*1.5, 32, 5])
                cube([spacing*2, 21, 6]);
        }
    }

}

module walls_basic(){
    x = width + 2*spacing;
    y = depth + 2*spacing;
    
    translate([0,-thickness,0])
        cube([x, thickness, height]);
    translate([0,y,0])
        cube([x, thickness, height]);
    translate([x,-thickness,0])
        cube([thickness,y + 2 * thickness, height]);
    translate([-thickness,-thickness,0])
        cube([thickness,y + 2* thickness, height]);
}

module peg(h) {
    cylinder(h = h, d = peg_bottom);
    cylinder(h = h *3, d = peg_up);
}