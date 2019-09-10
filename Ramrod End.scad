use <misc/threads.scad>; // https://dkprojects.net/openscad-threads/

thr_minor_d = 17;
thr_major_d = 20;
thr_l = 23;
thr_h = thr_major_d - thr_minor_d;
thr_p = 5;
thr_w = 4;

radius = 100;
barrel_d = 50;
thickness = 2.5;
concave_offset = -sqrt(pow(radius, 2) - pow(barrel_d / 2, 2));
concave_depth = radius + concave_offset;

$fn = 100;

difference() {
    difference() {
        union() {
            translate([0, 0, thickness])
            cylinder(
                h=thr_l + concave_depth,
                r1=barrel_d / 2,
                r2=thr_major_d / 2 + thickness
            );

            cylinder(
                h=thickness,
                r=barrel_d / 2
            );
        }

        translate([0, 0, concave_depth + thickness])
        cylinder(d=thr_major_d, h=thr_l);
        // metric_thread(
        //     diameter=thr_major_d,
        //     pitch=thr_p,
        //     length=thr_l,
        //     internal=true,
        //     n_starts=1,
        //     square=false,
        //     groove=false,
        //     rectangle=thr_h / thr_w,
        //     leadin=3
        // );

        translate([0, 0, concave_offset])
        sphere(r=radius);
    }

    translate([-500, 0, 0])
    cube(1000, center=true);
}