arrowSpread = 300;
arrowLength = 787.4;
arrowDiameter = 8.6;
holeDepth = 15;
minThickness = 2;
backInset = 0.35;
backInsetScale = 0.8;

fudge = 0.001;

module drawCorner(r, height) {
  translate([r, r]) rotate([0, 0, 180]) linear_extrude(height) difference() {
    square([r + fudge, r + fudge]);
    circle(r=r);
  }
}

module drawBlockPolyhedron(faceSize, h, angle) {
  translate([0, faceSize, 0]) rotate([90, 0, 0]) linear_extrude(faceSize)
    drawBlockPolygon(faceSize, h, angle);
}

module drawBlockPolygon(faceSize, h, angle) {
  x = faceSize;
  z = sin(90 - angle) * faceSize;
  n = cos(90 - angle) * faceSize;
  j = tan(angle) * (h - n);
  
  polygon([
    [j, 0],
    [2 * z + faceSize - j, 0],
    [2 * z + faceSize, h - n],
    [z + faceSize, h],
    [z, h],
    [0, h - n]
  ]);
}

module arrowShafts(spread, length, d, lift, inset, faceSize) {
  angle = asin(spread / (2 * length));
  o = faceSize * sin(angle);
  
  translate([0, 0, o - lift])
    for (a = [-angle, 0, angle])
      rotate([0, a, 0]) translate([0, 0, lift - inset])
        cylinder(h = length, r = d / 2);
}

module drawBlock() {
  faceSize = arrowDiameter + minThickness * 2;
  arrowAngle = asin(arrowSpread / (2 * arrowLength));
  arrowLift = faceSize / tan(arrowAngle);
  blockWidth = 2 * sin(90 - arrowAngle) * faceSize + faceSize;
  n = cos(90 - arrowAngle) * faceSize;
  blockHeight = holeDepth + n + minThickness;
  j = tan(arrowAngle) * (blockHeight - n);
  blockRadius = arrowDiameter - minThickness;

  echo("faceSize", faceSize);
  echo("arrowAngle", arrowAngle);
  echo("arrowLift", arrowLift);
  echo("blockWidth", blockWidth);
  echo("blockHeight", blockHeight);
  echo("blockRadius", blockRadius);

  difference() {
    translate([-blockWidth / 2, -faceSize / 2, 0])
      drawBlockPolyhedron(faceSize, blockHeight, arrowAngle);
    
    translate([
      blockWidth * backInsetScale / -2,
      -faceSize / 2 + faceSize + fudge,
      (blockHeight - blockHeight * backInsetScale) / 2
    ])
      rotate([90, 0, 0]) linear_extrude(backInset) scale(backInsetScale)
        drawBlockPolygon(faceSize, blockHeight, arrowAngle);
    
    $fn = 100;
    
    translate([0, 0, blockHeight - faceSize * sin(arrowAngle)])
      arrowShafts(arrowSpread, arrowLength, arrowDiameter, arrowLift, holeDepth, faceSize);
    
    $fn = 200;
    
    translate([blockWidth / -2 + j, faceSize / -2, 0]) rotate([0, -arrowAngle, 0])
      translate([0, 0, -blockHeight])
        drawCorner(blockRadius, blockHeight * 3);
    
    translate([blockWidth / 2 - j, faceSize / -2, 0]) rotate([0, arrowAngle, 0])
      rotate([0, 0, 90]) translate([0, 0, -blockHeight])
        drawCorner(blockRadius, blockHeight * 3);
  }
}

drawBlock();
