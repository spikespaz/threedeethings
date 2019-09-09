batt_w = 17;
batt_l = 26.1;
batt_h = 52.3;
shell_r = 3;
shell_t = 2;
lip_w = 2;
lip_h = 4;
wire_w = 1.4;
wire_s = 5;
wire_o = 5;
sw_d = 22;
sw_r = 4.88;
sw_nub_w = 1.4;

// Make a cube with four rounded sides.
module round_cube(xyz, r, center=false) {
    translate(center ? -[xyz[0] / 2, xyz[1] / 2, xyz[2] / 2] : [0, 0, 0]) hull() {
        translate([r,          r,          0]) cylinder(h=xyz[2], r=r);
        translate([r,          xyz[1] - r, 0]) cylinder(h=xyz[2], r=r);
        translate([xyz[0] - r, r,          0]) cylinder(h=xyz[2], r=r);
        translate([xyz[0] - r, xyz[1] - r, 0]) cylinder(h=xyz[2], r=r);
    }
}

module switch_hole(depth)
union() {
    cylinder(r=sw_r, h=depth);
    
    translate([0, 0, depth / 2])
    cube([sw_nub_w, (sw_r + sw_nub_w) * 2, depth], center=true);
}

module wire_holes(depth)
union() {
    translate([(wire_s + wire_w) / -2, 0, 0])
    cylinder(d=wire_w, h=depth, center=true);

    translate([(wire_s + wire_w) / 2, 0, 0])
    cylinder(d=wire_w, h=depth, center=true);
}

module shell_box()
difference() {
    body_w = batt_w + shell_t * 2;
    body_l = batt_l + shell_t * 2;
    body_h = batt_h + sw_d + shell_t;

    round_cube([body_w, body_l, body_h], shell_r);
    
    translate([shell_t, shell_t, shell_t])
    cube([batt_w, batt_l, batt_h + sw_d]);
}

module shell()
difference() {
    shell_box($fn=30);

    body_w = batt_w + shell_t * 2;
    body_h = batt_h + sw_d + shell_t;

    translate([body_w / 2, shell_t / 2, body_h - wire_w / 2 - wire_o + shell_t])
    rotate([90, 0, 0])
    wire_holes(shell_t, $fn=15);
}

module cover_solid()
union() {
    body_w = batt_w + shell_t * 2;
    body_l = batt_l + shell_t * 2;

    round_cube([body_w, body_l, shell_t], shell_r);
    
    translate([shell_t, shell_t, shell_t])
    difference() {
        round_cube([batt_w, batt_l, shell_t], 1);

        translate([lip_w, lip_w, 0])
        cube([batt_w - lip_w * 2, batt_l - lip_w, lip_h]);
    }
}

module cover()
difference() {
    body_w = batt_w + shell_t * 2;
    body_l = batt_l + shell_t * 2;

    cover_solid($fn=30);

    translate([body_w / 2, body_l / 2, 0])
    switch_hole(shell_t, $fn=50);
}

shell();

translate([batt_w + shell_t * 2 + 5, 0, 0])
cover();
