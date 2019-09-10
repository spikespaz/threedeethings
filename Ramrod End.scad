use <misc/threads.scad>; // https://dkprojects.net/openscad-threads/

thr_minor_d = 17;
thr_major_d = 20;
thr_l = 23;
thr_p = 5;
thr_w = 4;

radius = 80;
barrel_d = 50;
thickness = 2.5;

thr_h = thr_major_d - thr_minor_d;
conc_offset = -sqrt(pow(radius, 2) - pow(barrel_d / 2, 2));
conc_depth = radius + conc_offset;

$fn = 100;

module body_shape()
union() {
    translate([0, 0, conc_depth + thickness + thr_l / 2])
    cylinder(
        h=thr_l / 2,
        r=thr_major_d / 2 + thickness
    );

    translate([0, 0, thickness])
    cylinder(
        h=conc_depth + thr_l / 2,
        r1=barrel_d / 2,
        r2=thr_major_d / 2 + thickness
    );

    cylinder(
        h=thickness,
        r=barrel_d / 2
    );
}

module ramrod_end()
difference() {
    body_shape();

    translate([0, 0, conc_depth + thickness])
    metric_thread(
        diameter=thr_major_d,
        pitch=thr_p,
        length=thr_l,
        internal=true,
        n_starts=1,
        square=false,
        groove=false,
        rectangle=thr_h / thr_w
    );

    translate([0, 0, conc_offset])
    sphere(r=radius);
}

ramrod_end();