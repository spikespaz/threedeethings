d0 = 6;
d1 = 8;
l0 = 15;
l1 = 10;

union() {
  cylinder(r=d1 / 2, h=l1, $fn=6);
  
  translate([0, 0, l1])
    cylinder(r=d0 / 2, h=l0, $fn=50);
}