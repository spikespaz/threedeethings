use <misc/threads.scad>; // https://dkprojects.net/openscad-threads/

thr_minor_d = 17;
thr_major_d = 20;
thr_l = 23;
thr_h = thr_major_d - thr_minor_d;
thr_p = 5;
thr_w = 4;

depth = 10;
barrel_d = 50;

thickness = 2.5;

$fn = 100;

difference() {
    union() {
        translate([0, 0, thickness])
        cylinder(
            h=thr_l + depth,
            r1=barrel_d / 2,
            r2=thr_major_d / 2 + thickness
        );

        cylinder(
            h=thickness,
            r=barrel_d / 2
        );
    }

    translate([0, 0, depth + thickness])
    metric_thread(
        diameter=thr_major_d,
        pitch=thr_p,
        length=thr_l,
        internal=true,
        n_starts=1,
        square=false,
        groove=false,
        rectangle=thr_h / thr_w,
        leadin=3
    );

    resize([0, 0, depth])
    sphere(d=barrel_d - thickness * 2);
}
