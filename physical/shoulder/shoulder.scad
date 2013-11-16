
module bkThesisShoulder() {
	width = 60;
	height = 40;
	depth = 40; 
	
	module core() { 
		union() {
			cube([width, depth, height], center = true);
			translate([0,3,height - 31]) {
				rotate(a=[45,0,0]) cube([width / 2, depth, height + 10], center = true);
			}
		}
	}

	module hole() { 
		module armSide() {
			union() {
				translate([0,-32,0]) {
					resize(newsize=[width + 10,35,height + 30]) cylinder(height + 2,20,20, center = true);
					resize(newsize=[width - 10,40,height + 30]) cylinder(height + 2,20,20, center = true);

					translate([0,-1,0]) {
						rotate(a=[-3,0,0]) {
							resize(newsize=[width + 30,30,height + 50]) cylinder(height + 2,20,20, center = true);
							translate([0,-9,0]) {
								rotate(a=[-11,0,0]) {
									resize(newsize=[width - 5,38,height + 50]) cylinder(height + 2,20,20, center = true);
								}
							}	
						}
					}

				}	
			}
		}

		module corners() {
			union() {
				translate([-(width / 2) - 1,-(depth / 2) - 1,0]) {
					rotate(a=[0,0,45]) cube([6, 6, height + 2], center = true);
				}
				translate([(width / 2) + 1,(depth / 2) - 5,0]) {
					rotate(a=[0,0,45]) cube([6, 6, height + 2], center = true);
				}
				translate([-(width / 2) - 1,(depth / 2) - 5,0]) {
					rotate(a=[0,0,45]) cube([6, 6, height + 2], center = true);
				}
				translate([(width / 2) + 1,-(depth / 2) - 1,0]) {
					rotate(a=[0,0,45]) cube([6, 6, height + 2], center = true);
				}
				translate([-(width / 2) - 1,0, height - 20]) {
					rotate(a=[90,45,0]) cube([6, 6, height + 2], center = true);
				}
				translate([(width / 2) + 1,0,height - 20]) {
					rotate(a=[90,45,0]) cube([6, 6, height + 2], center = true);
				}
				translate([-(width / 2) - 1,0, height - 60]) {
					rotate(a=[90,45,0]) cube([6, 6, height + 2], center = true);
				}
				translate([(width / 2) + 1,0, height - 60]) {
					rotate(a=[90,45,0]) cube([6, 6, height + 2], center = true);
				}
				translate([0,0,-height]) {
					cube([width, depth, height], center = true);
				}
				translate([0,0,height + 5]) {
					cube([width, depth, height], center = true);
				}
			}
		}

		module frontPlate() {
			union() {
				translate([0,depth + 4,0]) {
					cube([width, depth, height], center = true);
				}
				translate([(width / 2) + 10,(depth / 2) + 22,0]) {
					rotate(a=[0,0,160]) cube([width, width, height * 4], center = true);
				}
				translate([-(width / 2) - 10,(depth / 2) + 22,0]) {
					rotate(a=[0,0,200]) cube([width, width, height * 4], center = true);
				}
				translate([0,2,22]) {
					cube([width - 10, depth - 18, height * 2], center = true);
				}
			}
		}
		
		module grips() {
			union() {
				translate([-(width / 2) + 12,-(depth / 2) - 1,-1]) {
					rotate(a=[0,0,55]) cube([3,depth, height * 0.3], center = true);
				}
				translate([(width / 2) + 1,-(depth / 2) + 8,-1]) {
					rotate(a=[0,0,305]) cube([3, depth, height * 0.3], center = true);
				}
				translate([-(width / 2) + 12,-(depth / 2) - 1,5]) {
					rotate(a=[0,45,55]) cube([2.1,depth, 2.1], center = true);
				}
				translate([(width / 2) + 1,-(depth / 2) + 8,5]) {
					rotate(a=[0,45,305]) cube([2.1, depth, 2.1], center = true);
				}
			}
		}

		module pattern() {

		}

		union() {
			armSide();
			corners();
			frontPlate();
			grips();
			pattern();
		}
	}

	difference() {
		core();
		hole();
	}
}

scale([1.3,1,0.9]) {
	bkThesisShoulder();
}
