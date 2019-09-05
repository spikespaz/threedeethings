// Radius (and approximate width) of the hook.
hook_r = 60; // [30:80]
// Total length of the hook.
hook_l = 80; // [50:120]
// Thickness of the walls of the hook.
hook_t = 3; // [2:5]
// Diameter of the hole created for mounting with a screw.
hole_d = 4; // [3:6]
// Offset for the screw hole relative to the inner edge of the top face of the base.
hole_o = 3; // [2:6]

$fn = 150;

hook();

module base_shape()
intersection() {
  translate([0, hook_r / 4, 0])
    circle(d=hook_r);
  translate([0, hook_r / -4, 0])
    circle(d=hook_r);
}

module extrude_shape()
difference() {
  base_shape();

  translate([0, hook_r / 4])
    circle(d=hook_r - hook_t * 2);
}

module hook()
difference() {
  union() {
    linear_extrude(hook_t) base_shape();
    linear_extrude(hook_l) extrude_shape();
  }

  translate([0, hook_r / -4 + hook_t + hole_o + hole_d / 2, 0])
    cylinder(d=hole_d, h=hook_t);
}
