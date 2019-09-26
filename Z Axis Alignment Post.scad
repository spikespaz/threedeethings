height = 75;
radius = 5;
rod_radius = 4.5;
base_width = 12;
base_height = 10;

$fn = 50;

difference() {
  union() {
    cube([base_width, base_width, base_height]);
    translate([base_width / 2, base_width / 2])
      cylinder(r=radius, h=height);
  }
  
  translate([base_width / 2, base_width, height + rod_radius / 2])
    rotate([90, 0, 0])
      cylinder(r=rod_radius, h=base_width);
}
