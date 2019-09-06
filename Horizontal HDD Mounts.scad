$fn = 100;

hdd_thickness = 25;
hdd_spacing = 10;
hdd_length = 146;
hdd_count = 6;
hdd_hole_diameter = 2.70;
hdd_mount_thickness = 3;

hdd_hole_0_offset_x = 15.40;
hdd_hole_1_offset_x = 76.00;
hdd_hole_2_offset_x = 117.50;

hole_margin = 10;
corner_radius = 5;

module hdd_mount() {
  difference() {
    square([hdd_length, hdd_thickness + hdd_spacing]);
    
    translate([0, hdd_spacing + 6.40, 0]) {
      translate([hdd_hole_0_offset_x, 0, 0])
        circle(d=hdd_hole_diameter, true);
      
      translate([hdd_hole_1_offset_x, 0, 0])
        circle(d=hdd_hole_diameter, true);
      
      translate([hdd_hole_2_offset_x, 0, 0])
        circle(d=hdd_hole_diameter, true);
    }
  }
}

module hdd_mount_holes() {
  hole_0_width = hdd_hole_1_offset_x - hdd_hole_0_offset_x - hole_margin / 2;
  hole_height = hdd_thickness + hdd_spacing - hole_margin / 2;
  
  translate([0, -hdd_hole_diameter / 2, 0]) {
    translate([hdd_hole_0_offset_x + hole_0_width / 2, 0, 0])
      resize([hole_0_width, hole_height, 0])
        circle(1);
    
    hole_1_width = hdd_hole_2_offset_x - hdd_hole_1_offset_x - hole_margin / 2;
     
    translate([hdd_hole_1_offset_x + hole_1_width / 2 + hole_margin / 2, 0, 0]) {
      resize([hole_1_width, hole_height, 0])
        circle(1);
    }
  }
}

module rounded_corner_negative(r, h) {
  difference() {
    cube([r, r, h]);
    
    translate([r, 0, 0])
      cylinder(h=h, r=r);
  }
}

module draw_hdd_mount() {
  difference() {
    linear_extrude(height=hdd_mount_thickness) {
      difference() {
        for (i = [0 : hdd_count - 1]) {
          translate([0, (hdd_thickness + hdd_spacing) * i, 0])
            hdd_mount();
        }
        
        for (i = [1 : hdd_count - 1]) {
          translate([0, (hdd_thickness + hdd_spacing) * i, 0])
            hdd_mount_holes();
        }
      }
    }
  
    translate([0, (hdd_thickness + hdd_spacing) * hdd_count - corner_radius, 0]) {
      rounded_corner_negative(corner_radius, hdd_mount_thickness);
      
      translate([hdd_length, 0, 0])
        mirror([1, 0, 0])
          rounded_corner_negative(corner_radius, hdd_mount_thickness);
    }
  }
}

draw_hdd_mount();


