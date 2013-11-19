
module bkThesisNeck() {
	width = 80;
	height = 40;
	depth = 80; 
	
	module core() { 
		union() {
			cube([width, depth, height], center = true);
			translate([-30,50,0]) {
				cube([20, 20, 40], center = true);
			}
			translate([-30,-50,0]) {
				cube([20, 20, 40], center = true);
			}	
		}
	}

	module hole() {

		module neck() {
			union() {
				translate([20.5,0,20]) {
					cube([width +1, depth +1, height + 1], center = true);
				}
				translate([-16,0,0]) {
					cube([width, depth -30, height + 1], center = true);
				}
				translate([-16,0,0]) {
					sphere([width, depth -30, height + 1], center = true);
				}
				cylinder(height + 2,34,34, center = true);

				translate([1,0,-10]) {
					rotate(a=[0,-10,0]) {
						cylinder(height * 2,34,34, center = true);
					}
					rotate(a=[0,10,0]) {
						cylinder(height * 2,34,34, center = true);
					}
				}
				translate([4,0,32]) {
					rotate(a=[90,0,0]) {
						cylinder(height * 4,41,41, center = true);
					}
				}
				translate([-20,0,36]) {
					rotate(a=[0,-60,0]) {
						cylinder(height,41,41, center = true);
					}
				}

			}
		}

		module sides() {
			union() {
				translate([20.5,46,0]) {
					rotate(a=[20,0,0]) {
						cube([width + 1, 20, 80], center = true);
					}
				}
				translate([0,46,-28]) {
					rotate(a=[340,-10,0]) {
						cube([width * 2, 20, 200], center = true);
					}
				}
				translate([-41,50,-20]) {
					rotate(a=[340,20,45]) {
						cube([20, 20, 40], center = true);
					}
				}
				translate([-41,40,36]) {
					rotate(a=[0,330,20]) {
						cube([40, 40, 40], center = true);
					}
				}
				translate([-60,46,17]) {
					rotate(a=[-10,310,-28]) {
						cube([40, 80, 40], center = true);
					}
				}
				translate([-15,40,28]) {
					rotate(a=[0,45,0]) {
						//cube([30, 40, 40], center = true);
					}
				}
				translate([-46,20,0]) {
					rotate(a=[0,0,45]) {
						cube([20, 20, height + 2], center = true);
					}
				}
			}
		}
		module back() {
			union() {
				translate([48,0,0]) {
					rotate(a=[0,45,0]) {
						cube([20, depth, 20], center = true);
					}
				}
			}
		}
		union() {
			neck();
			sides();
			mirror([0,-50,0]) {
				sides();
			}
			back();
		}
	}
	
	difference() {
		core();
		hole();
	}
}

bkThesisNeck();