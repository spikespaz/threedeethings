w0 = 6;
w1 = 8;
l0 = 15;
l1 = 10;

module p1() {
  $fn = 6;
  cylinder(r=w1 / 2, h=l1);
}

module p2() {
  $fn = 40;
  translate([0, 0, l1])
    cylinder(r=w0 / 2, h=l0);
}

p1();
p2();