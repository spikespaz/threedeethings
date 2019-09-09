block_angle_height = 10;
block_angle_measure = 50;
block_angle_chamfer = 45;
block_inset_length_0 = 29.9;
block_inset_length_1 = 35.5;
block_inset_depth = 10.4;
block_inset_width = 12;
block_burr_radius = 1.5;
block_burr_depth = 0.8;
block_sink_depth = 0.4;
block_sink_margin_sides = 4;
block_sink_margin_top = 2;

module block_burr() {
  resize([0, block_burr_depth * 2, 0])
    sphere(block_burr_radius, $fn=30);
}

module block_sink() {
  cube([100, block_sink_depth, block_inset_depth - block_sink_margin_top]);
}


module block_inset() {
  union() {
    difference() {
      translate([0, block_inset_width, 0]) rotate([90, 0, 0])
        linear_extrude(block_inset_width) polygon([
          [0, 0],
          [block_inset_length_0, 0],
          [block_inset_length_1, block_inset_depth],
          [0, block_inset_depth]
        ]);

      translate([block_inset_length_0 - block_sink_margin_sides - block_burr_radius, 0, 0]) {
        translate([0, block_inset_width - block_sink_depth, 0])
          block_sink();
      
        block_sink();
      }
    }

    translate([block_inset_length_0 - block_burr_radius, 0, block_inset_depth / 2]) {
      translate([0, block_sink_depth, 0])
        block_burr();

      translate([0, block_inset_width - block_sink_depth, 0])
        block_burr();
    }
  }
}

module block_angle() {
  difference() {
    rotate([90, 0, 90])
      linear_extrude(block_inset_length_1) polygon([
        [0, 0],
        [block_inset_width, 0],
        [block_angle_height / tan(block_angle_measure), block_angle_height]
      ]);

    rotate([0, block_angle_chamfer, 0]) translate([-100, 0, 0])
      cube([100, block_inset_width, 100]);

    translate([block_inset_length_1, 0, 0]) rotate([0, -block_angle_chamfer, 0])
      cube([100, block_inset_width, 100]);
  }
}

module block(orientation) {
  if (orientation == "right")
    translate([0, block_inset_width, 0]) rotate([0, 0, 180]) mirror([1, 0, 0])
      block("left");
  else
    union() {
      block_inset();

      translate([0, 0, block_inset_depth])
        block_angle();
    }
}

rotate([0, -90, 0])
  block("left");

translate([0, block_inset_width + 10, 0])
rotate([0, -90, 0])
  block("right");