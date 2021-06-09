$fn = 100;

row_count = 10;
column_count = 2;
slope_angle = 22.5;
edge_radius = 2;
edge_margin = 3;
slot_length = 24.2;
slot_width = 2.2;
slot_depth = 8;
slot_spacing = 2;

vertical_step = 1;

module rounded_cube(xyz, r) {
    hull() {
        translate([r,      r,            0]) cylinder(xyz.z, r=r);
        translate([xyz.x - r, r,         0]) cylinder(xyz.z, r=r);
        translate([xyz.x - r, xyz.y - r, 0]) cylinder(xyz.z, r=r);
        translate([r,         xyz.y - r, 0]) cylinder(xyz.z, r=r);
    }
}

module slot_column(slot_xyz, count, spacing, step) {   
    for (i = [0 : count - 1]) {
        translate([0, i * (slot_xyz.y + spacing), i * step])
            cube([slot_xyz.x, slot_xyz.y, slot_xyz.z]);
    }
}

module slots_negative(slot_xyz, rows, columns, slot_spacing, column_spacing, step) {
    for (i = [0 : columns - 1]) {
        translate([i * (slot_xyz.x + column_spacing), 0, 0])
            slot_column(slot_xyz, rows, slot_spacing, step);
    }
}

module card_holder(slot_xyz, rows, columns, slot_spacing, column_spacing, step, r) {
    box_width = (slot_xyz.x + column_spacing) * columns + column_spacing;
    box_height = (slot_xyz.y + slot_spacing) * rows + slot_spacing / 2 + column_spacing;
    
    difference() {
        rounded_cube([box_width, box_height, step * (rows - 1) + slot_xyz.z + 2], r=r);
        
            rotate([11.25, 0, 0]) translate([0, 0, slot_xyz.z])
            cube([1000, 1000, 1000]);
        
        translate([edge_margin, edge_margin, 2])
            slots_negative(slot_xyz, rows, columns, slot_spacing, column_spacing, step);
    }
}

card_holder([slot_length, slot_width, slot_depth],
            row_count,
            column_count,
            slot_spacing,
            edge_margin,
            vertical_step,
            edge_radius
);
